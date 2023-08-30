//
//  ARViewContainer.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 01.08.2023.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct ObjectARViewContainer: UIViewRepresentable {
    @Binding var entityConfirmedForPlacement: ModelEntity?
    @Binding var canBePlaced: Bool
    
    func makeUIView(context: Context) -> ObjectARView {
        let arView = ObjectARView(frame: .zero)
        arView.delegate = self
        return arView
    }
    
    func updateUIView(_ uiView: ObjectARView, context: Context) {
        guard let modelEntity = entityConfirmedForPlacement else { return }
        
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(modelEntity.clone(recursive: true))
        uiView.scene.addAnchor(anchorEntity)
        
        DispatchQueue.main.async {
            entityConfirmedForPlacement = nil
        }
    }
}

// MARK: - ObjectARViewDelegate
extension ObjectARViewContainer: ObjectARViewDelegate {
    func objectARView(_ view: ObjectARView, canBePlaced: Bool) {
        self.canBePlaced = canBePlaced
    }
}
