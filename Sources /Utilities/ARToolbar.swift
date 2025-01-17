//
//  ARToolbar.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import SwiftUI

public struct ARToolbar: View {
    public var body: some View {
        HStack {
            Button(action: { print("Open Settings") }) {
                Image(systemName: "gear")
            }
            Spacer()
            Button(action: { print("Plugin Active") }) {
                Image(systemName: "cube")
            }
            Spacer()
            Button(action: { print("Change Mode") }) {
                Image(systemName: "rectangule.3.offgrid.clip")
            }
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(10)
    }
}
