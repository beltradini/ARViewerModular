//
//  HighightPlugin.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

public class HighightPlugin: ARPlugin {
    public let name = "HighightPlugin"
    public let description = "Highlight objects"
    
    private var highlightedNode: SCNNode?
    
    public func activate(for view: ARSCNView) {
        // Lógica para resaltar objetos
    }
    
    public func deactivate() {
        highlightedNode?.removeFromParentNode()
    }
}
