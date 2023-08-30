//
//  CustomARView.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 04.08.2023.
//

import FocusEntity
import RealityKit
import ARKit
import Combine

protocol ObjectARViewDelegate {
    func objectARView(_ view: ObjectARView, canBePlaced: Bool)
}

final class ObjectARView: ARView {
    lazy var focusSquare = FocusEntity(on: self, focus: .plane)
    var delegate: ObjectARViewDelegate?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        focusSquare.delegate = self
        focusSquare.setAutoUpdate(to: true)
        
        setupARView()
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    private func setupARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
            session.run(config)
        }
    }
}

extension ObjectARView: FocusEntityDelegate {
    func focusEntity(_ focusEntity: FocusEntity, trackingUpdated trackingState: FocusEntity.State, oldState: FocusEntity.State?) {
        delegate?.objectARView(self, canBePlaced: trackingState != .initializing)
    }
}
