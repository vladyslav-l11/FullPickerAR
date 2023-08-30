//
//  ObjectItems.swift
//  PickerAR
//
//  Created by Vladyslav Lysenko on 24.08.2023.
//

import UIKit

enum ObjectItems: CaseIterable {
    case drummertoy
    case sneaker
    case wateringcan
    case flowers
    
    var image: UIImage {
        switch self {
        case .drummertoy:
            return R.image.ic_drummertoy()!
        case .sneaker:
            return R.image.ic_sneaker()!
        case .wateringcan:
            return R.image.ic_wateringcan()!
        case .flowers:
            return R.image.ic_flowers()!
        }
    }
    
    var name: String {
        switch self {
        case .drummertoy:
            return R.image.ic_drummertoy.name
        case .sneaker:
            return R.image.ic_sneaker.name
        case .wateringcan:
            return R.image.ic_wateringcan.name
        case .flowers:
            return R.image.ic_flowers.name
        }
    }
    
    var modelURL: URL {
        switch self {
        case .drummertoy:
            return R.file.drummertoyUsdz()!
        case .sneaker:
            return R.file.sneakerUsdz()!
        case .wateringcan:
            return R.file.wateringcanUsdz()!
        case .flowers:
            return R.file.flowersUsdz()!
        }
    }
}
