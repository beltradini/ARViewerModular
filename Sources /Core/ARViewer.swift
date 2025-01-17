//
//  ARViewer.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/15/25.
//

import ARKit
import SwiftUI
import SceneKit

struct ARViewer: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.delegate = context.coordinator
        arView.session.run(ARWorldTrackingConfiguration())
        arView.automaticallyUpdatesLighting = true
        
        // Add Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.tapGestureRecognized(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        // Load 3D Model
        let scene = SCNScene(named: "Droid_Tri_Fighter.usdz") // Reemplazar con tu archivo
        let node = SCNNode()
        node.position = SCNVector3(0, 0, -1) // 1 metro frente al usuario
        if let scene = scene {
            node.addChildNode(scene.rootNode)
        }
        arView.scene.rootNode.addChildNode(node)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        class Coordinator: NSObject, ARSCNViewDelegate {
            @objc func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
                guard let sceneView = sender.view as? ARSCNView else { return }
                let location = sender.location(in: sceneView)
                let hitResults = sceneView.hitTest(location, options: nil)
                
                if let hitNode = hitResults.first?.node {
                    print("Nodo seleccionado: \(hitNode.name ?? "Desconocido")")
                }
            }
        }
    }
}
