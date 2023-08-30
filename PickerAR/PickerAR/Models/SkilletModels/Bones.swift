//
//  File.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 13.08.2023.
//

import Foundation

enum Bones: CaseIterable {
    case leftShoulderToLeftArm
    case leftArmToLeftForearm
    case leftForearmToLeftHand

    case rightShoulderToRightArm
    case rightArmToRightForearm
    case rightForearmToRightHand

    case spine7ToLeftShoulder
    case spine7ToRightShoulder

    case neck1ToSpine7
    case spine7ToSpine6
    case spine6ToSpine5

    case hipsToLeftUpLeg
    case leftUpLegToLeftLeg
    case leftLegToLeftFoot

    case hipsToRightUpLeg
    case rightUpLegToRightLeg
    case rightLegToRightFoot

    var name: String {
        "\(jointFromName)-\(jointToName)"
    }

    var jointFromName: String {
        switch self {
        case .leftShoulderToLeftArm:
            return R.string.skilletKeys.leftShoulderJoint()
        case .leftArmToLeftForearm:
            return R.string.skilletKeys.leftArmJoint()
        case .leftForearmToLeftHand:
            return R.string.skilletKeys.leftForearmJoint()
        case .rightShoulderToRightArm:
            return R.string.skilletKeys.rightShoulderJoint()
        case .rightArmToRightForearm:
            return R.string.skilletKeys.rightArmJoint()
        case .rightForearmToRightHand:
            return R.string.skilletKeys.rightForearmJoint()
        case .spine7ToLeftShoulder, .spine7ToRightShoulder, .spine7ToSpine6:
            return R.string.skilletKeys.spine7Joint()
        case .neck1ToSpine7:
            return R.string.skilletKeys.neck1Joint()
        case .spine6ToSpine5:
            return R.string.skilletKeys.spine6Joint()
        case .hipsToLeftUpLeg, .hipsToRightUpLeg:
            return R.string.skilletKeys.hipsJoint()
        case .leftUpLegToLeftLeg:
            return R.string.skilletKeys.leftUpLegJoint()
        case .leftLegToLeftFoot:
            return R.string.skilletKeys.leftLegJoint()
        case .rightUpLegToRightLeg:
            return R.string.skilletKeys.rightUpLegJoint()
        case .rightLegToRightFoot:
            return R.string.skilletKeys.rightLegJoint()
        }
    }

    var jointToName: String {
        switch self {
        case .leftShoulderToLeftArm:
            return R.string.skilletKeys.leftArmJoint()
        case .leftArmToLeftForearm:
            return R.string.skilletKeys.leftForearmJoint()
        case .leftForearmToLeftHand:
            return R.string.skilletKeys.leftHandJoint()
        case .rightShoulderToRightArm:
            return R.string.skilletKeys.rightArmJoint()
        case .rightArmToRightForearm:
            return R.string.skilletKeys.rightForearmJoint()
        case .rightForearmToRightHand:
            return R.string.skilletKeys.rightHandJoint()
        case .spine7ToLeftShoulder:
            return R.string.skilletKeys.leftShoulderJoint()
        case .spine7ToRightShoulder:
            return R.string.skilletKeys.rightShoulderJoint()
        case .neck1ToSpine7:
            return R.string.skilletKeys.spine7Joint()
        case .spine7ToSpine6:
            return R.string.skilletKeys.spine6Joint()
        case .spine6ToSpine5:
            return R.string.skilletKeys.spine5Joint()
        case .hipsToLeftUpLeg:
            return R.string.skilletKeys.leftUpLegJoint()
        case .leftUpLegToLeftLeg:
            return R.string.skilletKeys.leftLegJoint()
        case .leftLegToLeftFoot:
            return R.string.skilletKeys.leftFootJoint()
        case .hipsToRightUpLeg:
            return R.string.skilletKeys.rightUpLegJoint()
        case .rightUpLegToRightLeg:
            return R.string.skilletKeys.rightLegJoint()
        case .rightLegToRightFoot:
            return R.string.skilletKeys.rightFootJoint()
        }
    }
}
