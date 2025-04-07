//
//  ModeManager.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

public class ModeManager {
    public static let shared = ModeManager()
    private var currentMode: ARMode?
    
    // Activa un modo
    public func activateMode(_ mode: ARMode, for view: ARSCNView) {
        currentMode = mode
        mode.configureScene(for: view)
        print("Activate mode: \(mode.name)")
    }
    
    // Obtiene el modo actual
    public func getCurrentMode() -> ARMode? {
        return currentMode
    }
}
