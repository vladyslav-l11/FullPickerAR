//
//  SkilletARViewContainer.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 13.08.2023.
//

import SwiftUI
import ARKit
import RealityKit

struct SkileltARViewContainer: UIViewRepresentable {
    @Binding var jointHue: Double
    @Binding var jointRadius: Double
    
    func makeUIView(context: Context) -> SkilletARView {
        let arView = SkilletARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true, bodySkeleton: nil, bodySkeletonAnchor: AnchorEntity())
        arView.setupForBodyTracking()
        arView.setupAnchor()
        return arView
    }
    
    func updateUIView(_ uiView: SkilletARView, context: Context) {
        uiView.jointHue = jointHue
        uiView.jointRadius = jointRadius
    }
}
