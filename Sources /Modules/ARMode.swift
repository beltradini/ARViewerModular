//
//  ARMode.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit
import Foundation

public protocol ARMode {
    var name: String { get }
    var description: String { get }
    var icon: String { get } // UI
    var isActive: Bool { get }

    // Configurate the AR session
    func configureScene(for view: ARSCNView)
    func willActivate()
    func didDeactivate()
    func handleUserInteraction(_ gesture: UIGestureRecognizer, in view: ARSCNView)
}

public extension ARMode {
    var isActive: Bool { false }
    func willActivate() {}
    func didDeactivate() {}
    func handleUserInteraction(_ gesture: UIGestureRecognizer, in view: ARSCNView) {
        // Default implementation does nothing
    }
}

public enum LogLevel {
    case debug, info, warning, error
}

public class ARLogger {
    public func log(_ message: String, level: LogLevel = .info, file: String = #file, function: String = #function) {
        let fileName = (file as NSString).lastPathComponent
        let timestamp = DateFormatter().string(from: Date())
        let logMessage = "[\(timestamp)] [\(fileName):\(function)] [\(level)] \(message)"
        print(logMessage)
    }
}
