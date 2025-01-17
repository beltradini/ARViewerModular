//
//  MeasurementViewController.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/17/25.
//
// Prototype

import UIKit
import ARKit
import SceneKit

class MeasurementViewController: UIViewController, ARSKViewDelegate {
    
    // MARK: - Properties
    var sceneView: ARSKView!
    var points: [SCNNode] = []
    var distanceLabel: UILabel!
    
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
        sceneView = ARSKView(frame: view.bounds)
        sceneView.delegate = self
        view.addSubview(sceneView)
    }
    
    func setupUI() {
        distanceLabel = UILabel(frame: CGRect(x: 20, y: 40, width: 200, height: 40))
        distanceLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        distanceLabel.textColor = .white
        distanceLabel.textAlignment = .center
        distanceLabel.text = "Distance: 0.0 m"
        distanceLabel.layer.cornerRadius = 8
        distanceLabel.clipsToBounds = true
        view.addSubview(distanceLabel)
    }
    
    func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    func startARSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: - Gesture Handling
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(location, types: [.featurePoint])
        
        if let result = hitTestResults.first {
            addPoint(at: result.worldTransform)
            if points.count == 2 {
                calculateDistance()
            }
        }
    }
    
    // MARK: - Point Handling
    func addPoint(at transform: matrix_half4x4) {
        let sphere = SCNSphere(radius: 0.01)
        sphere.firstMaterial?.diffuse.contents = UIColor.red
        
        let pointNode = SCNNode(geometry: sphere)
        pointNode.position = SCNVector3(
            transform.columns.3.x,
            transform.columns.3.y,
            transform.columns.3.z
        )
        
        sceneView.scene.rootNode.addChild(pointNode)
        points.append(pointNode)
    }
    
    func calculateDistance() {
        guard points.count == 2 else { return }
        
        let start = points[0].position
        let end = points[1].position
        
        let distance = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2) + pow(end.z - start.z, 2))
        
        displayDistance(distance)
        drawLine(from: points[0], to: points[1])
    }
    
    func displayDistance(_ distance: Float) {
        distanceLabel.text = String(format: "%.2f m", distance)
    }
    
    func drawLine(from start: SCNNode, to end: SCNNode) {
        let lineGeometry = SCNGeometry.line(from: start.position, to: end.position)
        let lineNode = SCNNode(geometry: lineGeometry)
        lineNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        sceneView.scene.rootNode.addChildNode(lineNode)
    }
}

// MARK: - Line Geometry Extension
extension SCNGeometry {
    static func line(from start: SCNVector3, to end: SCNVector3) -> SCNGeometry {
        let vertices: [SCNVector3] = [start, end]
        let vertexSource = SCNGeometrySource(vertices: vertices)
        
        let indices: [Int32] = [0, 1]
        let indexData = Data(bytes: indices, count: MemoryLayout<Int32>.size * indices.count)
        
        let element = SCNGeometryElement(
            data: indexData,
            primitiveType: .line,
            primitiveCount: 1,
            bytesPerIndex: MemoryLayout<Int32>.size
        )
        
        return SCNGeometry(
            sources: [vertexSource],
            elements: [element]
        )
    }
}
