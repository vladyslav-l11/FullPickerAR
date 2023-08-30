//
//  SkilletARView.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 13.08.2023.
//

import RealityKit
import ARKit

final class SkilletARView: ARView {
    private var bodySkeleton: BodySkillet?
    private var bodySkeletonAnchor: AnchorEntity?
    
    var jointHue: Double = 0
    var jointRadius: Double = 1
    
    init(frame frameRect: CGRect, cameraMode: ARView.CameraMode, automaticallyConfigureSession: Bool, bodySkeleton: BodySkillet?, bodySkeletonAnchor: AnchorEntity) {
        super.init(frame: frameRect, cameraMode: cameraMode, automaticallyConfigureSession: automaticallyConfigureSession)
        self.bodySkeleton = bodySkeleton
        self.bodySkeletonAnchor = bodySkeletonAnchor
    }
    
    required dynamic init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    required dynamic init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    func setupAnchor() {
        bodySkeletonAnchor.flatMap { scene.addAnchor($0) }
    }
}

extension SkilletARView: ARSessionDelegate {
    func setupForBodyTracking() {
        let configuration = ARBodyTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        configuration.frameSemantics.insert(.bodyDetection)
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        session.delegate = self
    }

    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let bodyAnchor = anchor as? ARBodyAnchor else { return }
            if let skeleton = bodySkeleton {
                skeleton.update(with: bodyAnchor,
                                jointColor: UIColor(hue: jointHue, saturation: 1, brightness: 1, alpha: 1),
                                jointRadius: jointRadius)
            } else {
                bodySkeleton = BodySkillet(for: bodyAnchor)
                bodySkeleton?.setupSkeleton(withJointColor: UIColor(hue: jointHue,
                                                                    saturation: 1,
                                                                    brightness: 1,
                                                                    alpha: 1),
                                            jointRadius: jointRadius)
                bodySkeleton.flatMap { [weak self] in self?.bodySkeletonAnchor?.addChild($0) }
            }
        }
    }
}
