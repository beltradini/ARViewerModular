//
//  ARViewerModularTests.swift
//  ARViewerModularTests
//
//  Created by Alejandro Beltrán on 1/15/25.
//

import Testing
import ARKit
import XCTest
@testable import ARViewerModular

struct ARViewerModularTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    func testTapGestureRecognition() {
        let arView = ARSCNView()
        let coordinator = ARViewer.Coordinator()
        
        let tapLocation = CGPoint(x: 100, y: 100)
        let tapGesture = UITapGestureRecognizer()
        tapGesture.location(in: arView) // Simular ubicación de toque
        
        coordinator.tapGestureRecognized(tapGesture, in: arView)
        XCTAssertNotNil(coordinator.selectedNode, "Nodo no seleccionado")
    }
}

