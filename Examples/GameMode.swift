//
//  GameMode.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

public class GameMode: ARMode {
    public let name = "Game"
    public let description = "A basic game mode."
    
    public func configureScene(for view: ARSCNView) {
        // Limpia la escena
        view.scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        
        // Agrega un objeto dinamico
        let sphere = SCNSphere(radius: 0.1)
        sphere.firstMaterial?.diffuse.contents = UIColor.red
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        sphereNode.position = SCNVector3(0, 0.1, 0)
        view.scene.rootNode.addChildNode(sphereNode)
        
        print("ArViewerModular: Game mode configured.")
    }
}
