//
//  ARPlugin.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

public protocol ARPlugin {
    // Plugin name (used for identification)
    var name: String { get }
    
    // Description of the purpose of the plugin
    var description: String { get }
    
    // Initialisation of resources needed for the plugin
    func activate(for view: ARSCNView)
    
    // Cleaning of resources or deactivation
    func deactivate()
}
