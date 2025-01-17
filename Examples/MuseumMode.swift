//
//  MuseumMode.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

public class MuseumMode: ARMode {
    public let name = "Museum"
    public let description = "Explore the museum."
    
    public func configureScene(for view: ARSCNView) {
        // Limpia la escena
        view.scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }
        
        // Agrega etiquetas interactivas a los objetos
        let text = SCNText(string: "Historic Object", extrusionDepth: 1)
        text.firstMaterial?.diffuse.contents = UIColor.white
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(0, 0.1, 0)
        view.scene.rootNode.addChildNode(textNode)
        
        print("Activando el modo de museo...")
    }
}
