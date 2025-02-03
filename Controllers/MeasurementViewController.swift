// 
// MeasurementViewController.swift
// ARViewer
//
// Created by Alejandro on 2/03/25.
//

import UIKit
import ARKit 

@main
class AppDelegate: UIResponsable, UIApplicationDelegate {
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

// MARK: - MeasurementViewController
class MeasurementViewController: UIViewController, ARSCNViewDelegate {


  // MARK: - Properties
  var sceneView: ARSCNView!
  var points: [SCNNode] = []
  var totalDistance: Float = 0.0
  var distanceLabel: UILabel!

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSceneView()
    setupUI()
    setupDistanceLabel()
    addGestureRecognizers()
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
    sceneView = ARSCNView()
    sceneView.delegate = self
    sceneView.showsStatistics = true
    sceneView.autoenablesDefaultLighting = true
    view.addSubview(sceneView)
  }

  func setupUI() {
    distanceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
    distanceLabel.bakgroundColor = UIColor.black.withAlphaComponent(0.5)
    distanceLabel.textColor = .white
    distanceLabel.textAlignment = .center
    distanceLabel.text = "Total distance: 0.0 m"
    distanceLabel.layer.cornerRadius = 10
    distanceLabel.clipsToBounds = true
    view.addSubview(distanceLabel)
  }

  func addGestureRecognizers() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    sceneView.addGestureRecognizer(tapGestureRecognizer)
  }

  func startARSession() {
    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = .horizontal
    sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
  }

  // MARK: - Gesture Handling 



  
}



