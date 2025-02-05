//
//  MeasurementViewController.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/17/25.
//

import UIKit
import ARKit

class MeasurementViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var startPoint: SCNNode?
    var endPoint: SCNNode?
    var lineNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.session.run(ARWorldTrackingConfiguration())
        sceneView.debugOptions = [.showFeaturePoints]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: sceneView)
        
        if let query = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .any),
           let result = sceneView.session.raycast(query).first {
            
            let position = SCNVector3(result.worldTransform.columns.3.x,
                                      result.worldTransform.columns.3.y,
                                      result.worldTransform.columns.3.z)
            
            if startPoint == nil {
                startPoint = createSphere(at: position, color: .red)
                sceneView.scene.rootNode.addChildNode(startPoint!)
            } else if endPoint == nil {
                endPoint = createSphere(at: position, color: .blue)
                sceneView.scene.rootNode.addChildNode(endPoint!)
                drawLine()
            } else {
                resetMeasurement()
            }
        }
    }
    
    func createSphere(at position: SCNVector3, color: UIColor) -> SCNNode {
        let sphere = SCNSphere(radius: 0.01)
        sphere.firstMaterial?.diffuse.contents = color
        let node = SCNNode(geometry: sphere)
        node.position = position
        return node
    }
    
    func drawLine() {
        guard let start = startPoint, let end = endPoint else { return }
        
        let line = SCNGeometry.line(from: start.position, to: end.position)
        lineNode = SCNNode(geometry: line)
        sceneView.scene.rootNode.addChildNode(lineNode!)
        
        let distance = start.position.distance(to: end.position)
        print("Distancia: \(distance) metros")
    }
    
    func resetMeasurement() {
        startPoint?.removeFromParentNode()
        endPoint?.removeFromParentNode()
        lineNode?.removeFromParentNode()
        startPoint = nil
        endPoint = nil
        lineNode = nil
    }
}

extension SCNGeometry {
    static func line(from vectorA: SCNVector3, to vectorB: SCNVector3) -> SCNGeometry {
        let vertices: [SCNVector3] = [vectorA, vectorB]
        let indices: [Int32] = [0, 1]
        
        let vertexSource = SCNGeometrySource(vertices: vertices)
        let indexData = Data(bytes: indices, count: indices.count * MemoryLayout<Int32>.size)
        let element = SCNGeometryElement(data: indexData, primitiveType: .line, primitiveCount: 1, bytesPerIndex: MemoryLayout<Int32>.size)
        
        return SCNGeometry(sources: [vertexSource], elements: [element])
    }
}

extension SCNVector3 {
    func distance(to vector: SCNVector3) -> Float {
        return sqrt(pow(vector.x - x, 2) + pow(vector.y - y, 2) + pow(vector.z - z, 2))
    }
}
