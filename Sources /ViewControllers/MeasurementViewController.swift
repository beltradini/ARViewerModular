//
//  MeasurementViewController.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/17/25.
//
// Prototype

// Example App for AR Measurement Tool

import UIKit
import ARKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MeasurementViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

// MeasurementViewController.swift
import UIKit
import ARKit

class MeasurementViewController: UIViewController, ARSCNViewDelegate {

    // MARK: - Properties
    var sceneView: ARSCNView!
    var points: [SCNNode] = []
    var totalDistance: Float = 0.0
    var distanceLabel: UILabel!
    var areaLabel: UILabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSceneView()
        setupUI()
        addTapGestureRecognizer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startARSession()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    // MARK: - Setup Methods
    func setupSceneView() {
        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        view.addSubview(sceneView)
    }

    func setupUI() {
        distanceLabel = UILabel(frame: CGRect(x: 20, y: 40, width: 200, height: 40))
        distanceLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        distanceLabel.textColor = .white
        distanceLabel.textAlignment = .center
        distanceLabel.text = "Distance: 0.00 m"
        distanceLabel.layer.cornerRadius = 8
        distanceLabel.clipsToBounds = true
        view.addSubview(distanceLabel)
        
        areaLabel = UILabel(frame: CGRect(x: 20, y: 90, width: 200, height: 40))
        areaLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        areaLabel.textColor = .white
        areaLabel.textAlignment = .center
        areaLabel.text = "Area: 0.00 m²"
        areaLabel.layer.cornerRadius = 8
        areaLabel.clipsToBounds = true
        view.addSubview(areaLabel)
    }

    func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
    }

    func startARSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    // MARK: - Gesture Handling
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(location, types: [.featurePoint])

        if let result = hitTestResults.first {
            addPoint(at: result.worldTransform)
            if points.count > 1 {
                calculateDistance()
            }
            if points.count > 2 {
                calculateArea()
            }
        }
    }

    // MARK: - Point Handling
    func addPoint(at transform: matrix_float4x4) {
        let sphere = SCNSphere(radius: 0.01)
        sphere.firstMaterial?.diffuse.contents = UIColor.red

        let pointNode = SCNNode(geometry: sphere)
        pointNode.position = SCNVector3(
            transform.columns.3.x,
            transform.columns.3.y,
            transform.columns.3.z
        )

        sceneView.scene.rootNode.addChildNode(pointNode)
        points.append(pointNode)
    }

    func calculateDistance() {
        guard points.count > 1 else { return }

        let start = points[points.count - 2].position
        let end = points[points.count - 1].position

        let distance = sqrt(
            pow(end.x - start.x, 2) +
            pow(end.y - start.y, 2) +
            pow(end.z - start.z, 2)
        )

        totalDistance += distance
        displayDistance(totalDistance)
        drawLine(from: points[points.count - 2], to: points[points.count - 1])
    }

    func displayDistance(_ distance: Float) {
        distanceLabel.text = String(format: "Distance: %.2f m", distance)
    }
    
    func calculateArea() {
        guard points.count > 2 else { return }
        
        var area: Float = 0.0
        let origin = points[0].position
        
        for i in 1..<points.count - 1 {
            let p1 = points[i].position
            let p2 = points[i + 1].position
            
            let vector1 = SCNVector3(p1.x - origin.x, p1.y - origin.y, p1.z - origin.z)
            let vector2 = SCNVector3(p2.x - origin.x, p2.y - origin.y, p2.z - origin.z)
            
            let crossProduct = SCNVector3(
                vector1.y * vector2.z - vector1.z * vector2.y,
                vector1.z * vector2.x - vector1.x * vector2.z,
                vector1.x * vector2.y - vector1.y * vector2.x
            )
            
            let triangleArea = 0.5 * sqrt(
                crossProduct.x * crossProduct.x +
                crossProduct.y * crossProduct.y +
                crossProduct.z * crossProduct.z
            )
            
            area += triangleArea
        }
        
        displayArea(area)
    }
    
    func displayArea(_ area: Float) {
        areaLabel.text = String(format: "Area: %.2f m²", area)
    }

    func drawLine(from start: SCNNode, to end: SCNNode) {
        let lineGeometry = SCNGeometry.line(from: start.position, to: end.position)
        let lineNode = SCNNode(geometry: lineGeometry)
        lineNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        sceneView.scene.rootNode.addChildNode(lineNode)
    }
}
