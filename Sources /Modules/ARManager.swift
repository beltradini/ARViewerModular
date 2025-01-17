//
//  ARManager.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

class ARManager {
    static let shared = ARManager()
    private let configuration = ARWorldTrackingConfiguration()
    
    func setupARScene(for view: ARSCNView) {
        view.session.run(configuration)
        view.automaticallyUpdatesLighting = true
    }
    
    func addModel(named name: String, to view: ARSCNView) {
        let scene = SCNScene(named: "\(name).usdz")
        let node = SCNNode()
        node.position = SCNVector3(0, 0, -1)
        if let scene = scene {
            node.addChildNode(scene.rootNode)
        }
        view.scene.rootNode.addChildNode(node)
    }
}
