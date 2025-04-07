//
//  VisionHandler.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/15/25.
//

import Vision
import AVFoundation
import SceneKit
import ARKit

class VisionHandler {
    private var request: VNCoreMLRequest?
    var arView: ARSCNView
    
    init(arView: ARSCNView) {
        self.arView = arView
        // Cargar un modelo CoreML básico (MobileNetV2 o similar)
        guard let model = try? VNCoreMLModel(for: MobileNetV2(configuration: MLModelConfiguration()).model) else { return }
        self.request = VNCoreMLRequest(model: model, completionHandler: handleDetection)
    }
    
    func handleDetection(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else { return }
        for result in results {
            print("\(result.identifier): \(result.confidence)")
        }
    }
    
    func performDetection(on pixelBuffer: CVPixelBuffer) {
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([self.request!])
    }
    
    func hanldeDetection(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else { return }
        
        DispatchQueue.main.async {
            for result in results {
                let label = SCNText(string: "\(result.identifier): \(Int(result.confidence * 100))%", extrusionDepth: 1)
                let labelNode = SCNNode(geometry: label)
                labelNode.scale = SCNVector3(0.01, 0.01, 0.01)
                labelNode.position = SCNVector3(0, 0.5, -0.5) // Ajustar posición relativa al objeto detectado
                
                // Enlazar la etiqueta al modelo o la escena
                self.arView.scene.rootNode.addChildNode(labelNode)
            }
        }
    }
}

