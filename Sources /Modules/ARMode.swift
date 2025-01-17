//
//  ARMode.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

public protocol ARMode {
    // Nombre del modo
    var name: String { get }
    
    // Descripción del proposito del modo
    var description: String { get }
    
    // Configura la escena AR especifica para este modo
    func configureScene(for view: ARSCNView)
}
