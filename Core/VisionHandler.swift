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
        guard let model = try? VNCoreMLModel(for: MobileNetV2(configuration: MLModelConfiguration()).model) else { return }
        self.request = VNCoreMLRequest(model: model, completionHandler: handleDetection)
    }
    
    func performDetection(on pixelBuffer: CVPixelBuffer) {
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([self.request!])
    }

    func handleDetection(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else { return }
        
        DispatchQueue.main.async {
            for result in results {
                let label = SCNText(string: "\(result.identifier): \(Int(result.confidence * 100))%", extrusionDepth: 1)
                let labelNode = SCNNode(geometry: label)
                labelNode.scale = SCNVector3(0.01, 0.01, 0.01)
                labelNode.position = SCNVector3(0, 0.5, -0.5) 

                self.arView.scene.rootNode.addChildNode(labelNode)
            }
        }
    }
}

