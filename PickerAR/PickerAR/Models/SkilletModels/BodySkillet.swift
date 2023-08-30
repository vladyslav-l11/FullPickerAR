//
//  BodySkillet.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 13.08.2023.
//

import RealityKit
import ARKit

class BodySkillet: Entity {
    var joints: [String: ModelEntity] = [:]
    var bones: [String: ModelEntity] = [:]
    
    private var bodyAnchor: ARBodyAnchor?
    private var shouldUpdateJointSize = true

    var headParts: [String] {
        [
            R.string.skilletKeys.neck1Joint(),
            R.string.skilletKeys.neck2Joint(),
            R.string.skilletKeys.neck3Joint(),
            R.string.skilletKeys.neck4Joint(),
            R.string.skilletKeys.headJoint(),
            R.string.skilletKeys.leftShoulderJoint(),
            R.string.skilletKeys.rightShoulderJoint()
        ]
    }

    var topBodyParts: [String] {
        [
            R.string.skilletKeys.jawJoint(),
            R.string.skilletKeys.chinJoint(),
            R.string.skilletKeys.leftEyeJoint(),
            R.string.skilletKeys.leftEyeLowerLidJoint(),
            R.string.skilletKeys.leftEyeUpperLidJoint(),
            R.string.skilletKeys.leftEyeballJoint(),
            R.string.skilletKeys.noseJoint(),
            R.string.skilletKeys.rightEyeJoint(),
            R.string.skilletKeys.rightEyeLowerLidJoint(),
            R.string.skilletKeys.rightEyeUpperLidJoint(),
            R.string.skilletKeys.rightEyeballJoint()
        ]
    }

    var handParts: [String] {
        [
            R.string.skilletKeys.leftHandJoint(),
            R.string.skilletKeys.rightHandJoint()
        ]
    }

    required init(for bodyAnchor: ARBodyAnchor) {
        self.bodyAnchor = bodyAnchor
        super.init()
    }

    required init() {}
    
    func setupSkeleton(withJointColor jointColor: UIColor, jointRadius: Double) {
        for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
            var startJointRadius: Float = 0.05

            switch jointName {
            case _ where headParts.contains(where: { $0 == jointName }):
                startJointRadius *= 0.5
            case _ where topBodyParts.contains(where: { $0 == jointName }):
                startJointRadius *= 0.2
            case _ where jointName.hasPrefix(R.string.skilletKeys.spine()):
                startJointRadius *= 0.75
            case _ where handParts.contains(where: { $0 == jointName }):
                startJointRadius *= 1
            case _ where jointName.hasPrefix(R.string.skilletKeys.leftHand())
                || jointName.hasPrefix(R.string.skilletKeys.rightHand()):
                startJointRadius *= 0.25
            case _ where jointName.hasPrefix(R.string.skilletKeys.leftToes())
                || jointName.hasPrefix(R.string.skilletKeys.rightToes()):
                startJointRadius *= 0.5
            default:
                startJointRadius = 0.05
            }

            let jointEntity = createJoint(radius: Float(jointRadius) * startJointRadius, color: jointColor)
            joints[jointName] = jointEntity
            addChild(jointEntity)
        }

        for bone in Bones.allCases {
            guard let bodyAnchor = bodyAnchor,
                  let skeletonBone = createSkeletonBone(bone: bone, bodyAnchor: bodyAnchor) else {
                continue
            }
            let boneEntity = createBoneEntity(for: skeletonBone)
            bones[bone.name] = boneEntity
            addChild(boneEntity)
        }
    }

    func update(with bodyAnchor: ARBodyAnchor, jointColor: UIColor, jointRadius: Double) {
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        
        if shouldUpdateJointSize {
            shouldUpdateJointSize = false
            
            for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
                guard let jointEntity = joints[jointName],
                      let jointEntityTransform = bodyAnchor.skeleton
                    .modelTransform(for: ARSkeleton.JointName(rawValue: jointName)) else {
                    return
                }
                
                var startJointRadius: Float = 0.05

                switch jointName {
                case _ where headParts.contains(where: { $0 == jointName }):
                    startJointRadius *= 0.5
                case _ where topBodyParts.contains(where: { $0 == jointName }):
                    startJointRadius *= 0.2
                case _ where jointName.hasPrefix(R.string.skilletKeys.spine()):
                    startJointRadius *= 0.75
                case _ where handParts.contains(where: { $0 == jointName }):
                    startJointRadius *= 1
                case _ where jointName.hasPrefix(R.string.skilletKeys.leftHand())
                    || jointName.hasPrefix(R.string.skilletKeys.rightHand()):
                    startJointRadius *= 0.25
                case _ where jointName.hasPrefix(R.string.skilletKeys.leftToes())
                    || jointName.hasPrefix(R.string.skilletKeys.rightToes()):
                    startJointRadius *= 0.5
                default:
                    startJointRadius = 0.05
                }
                
                let jointEntityOffsetFromRoot = simd_make_float3(jointEntityTransform.columns.3)
                jointEntity.model?.materials[0] = SimpleMaterial(color: jointColor,
                                                                 roughness: 0.8,
                                                                 isMetallic: false)
                jointEntity.model?.mesh = MeshResource.generateSphere(radius: Float(jointRadius) * startJointRadius)
                jointEntity.position = jointEntityOffsetFromRoot + rootPosition
                jointEntity.orientation = Transform(matrix: jointEntityTransform).rotation
            }

            for bone in Bones.allCases {
                guard let entity = bones[bone.name],
                      let skeletonBone = createSkeletonBone(bone: bone, bodyAnchor: bodyAnchor) else {
                    continue
                }
                entity.position = skeletonBone.centerPosition
                entity.look(at: skeletonBone.toJoint.position,
                            from: skeletonBone.centerPosition,
                            relativeTo: nil)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.shouldUpdateJointSize = true
            }
        }
    }

    private func createJoint(radius: Float, color: UIColor = .white) -> ModelEntity {
        let mesh = MeshResource.generateSphere(radius: radius)
        let material = SimpleMaterial(color: color, roughness: 0.8, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }

    private func createSkeletonBone(bone: Bones, bodyAnchor: ARBodyAnchor) -> SkilletBone? {
        guard let fromJointEntityTransform = bodyAnchor.skeleton
            .modelTransform(for: ARSkeleton.JointName(rawValue: bone.jointFromName)),
              let toJointEntityTransform = bodyAnchor.skeleton
            .modelTransform(for: ARSkeleton.JointName(rawValue: bone.jointToName)) else {
            return nil
        }

        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        let jointFromEntityOffsetFromRoot = simd_make_float3(fromJointEntityTransform.columns.3)
        let jointFromEntityPosition = jointFromEntityOffsetFromRoot + rootPosition
        let jointToEntityOffsetFromRoot = simd_make_float3(toJointEntityTransform.columns.3)
        let jointToEntityPosition = jointToEntityOffsetFromRoot + rootPosition

        let fromJoint = SkilletJoint(name: bone.jointFromName, position: jointFromEntityPosition)
        let toJoint = SkilletJoint(name: bone.jointToName, position: jointToEntityPosition)
        return SkilletBone(fromJoint: fromJoint, toJoint: toJoint)
    }

    private func createBoneEntity(for skilletBone: SkilletBone, color: UIColor = .white) -> ModelEntity {
        let diameter: Float = 0.04
        let mesh = MeshResource.generateBox(size: [diameter, diameter, skilletBone.length],
                                            cornerRadius: diameter / 2)
        let material = SimpleMaterial(color: color, roughness: 0.5, isMetallic: true)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }
}
