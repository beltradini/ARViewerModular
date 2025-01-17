//
//  DecorationMode.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

public class DecorationMode: ARMode {
    public let name = "Decoration"
    public let description = "Add decorations to your scene."
    
    public func configureScene(for view: ARSCNView) {
        // Limpia la escena
        view.scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        
        // Configura un plano horizontal para colocar objetos
        let planeGeometry = SCNPlane(width: 2, height: 2)
        planeGeometry.firstMaterial?.diffuse.contents = UIColor.gray
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.eulerAngles.x = -.pi / 2
        view.scene.rootNode.addChildNode(planeNode)
        
        print("Mode \(name) configured.")
    }
}
