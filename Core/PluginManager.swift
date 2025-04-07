//
//  PluginManager.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

public class PluginManager {
    public static let shared = PluginManager()
    private var plugins: [String: ARPlugin] = [:]
    
    // Registra un plugin disponible
    public func registerPlugin(_ plugin: ARPlugin) {
        plugins[plugin.name] = plugin
    }
    
    // Activa un plugin por nombre
    public func activatePlugin(named name: String, for view: ARSCNView) {
        guard let plugin = plugins[name] else { return }
        plugin.activate(for: view)
    }
    
    // Desactiva un plugin por nombre
    public func deactivatePLugin(named name: String) {
        guard let plugin = plugins[name] else { return }
        plugin.deactivate()
    }
    
    // Lista los pluglins registrados
    public func listPlugins() -> [String] {
        return plugins.keys.sorted()
    }
}
