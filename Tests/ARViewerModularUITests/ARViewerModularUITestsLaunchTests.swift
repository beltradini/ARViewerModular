//
//  ARViewerModularUITestsLaunchTests.swift
//  ARViewerModularUITests
//
//  Created by Alejandro Beltrán on 1/15/25.
//

import XCTest
@testable import ARViewerModular

final class ARViewerModularUITestsLaunchTests: XCTestCase {
    func testARViewerInitialization() {
        let viewer = ARViewer()
        XCTAssertNotNil(viewer, "ARViewer initialization failed")
    }
    
    func testVisionHanlderInitialization() {
        let visionHandler = VisionHandler()
        XCTAssertNotNil(visionHandler, "VisionHandler initialization failed")
    }

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
