//
//  AvatarIconsUploadProgressTypes.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import Foundation
import Symbols

enum AvatarIconsUploadProgressTypes: String, CaseIterable {
    case uploading, processing, writing, completed
    
    var model: AvatarIconsUploadProgressModel {
        switch self {
        case .uploading:
            return .init(
                type: self,
                description: "Uploading\nto Storage",
                systemImageName: "icloud.and.arrow.up.fill",
                effect: .wiggle,
                behavior: .repeat(.continuous)
            )
        case .processing:
            return .init(
                type: self,
                description: "Processing\nData",
                systemImageName: "arrow.trianglehead.2.clockwise.rotate.90.icloud.fill",
                effect: .rotate,
                behavior: .repeat(.continuous)
            )
        case .writing:
            return .init(
                type: self,
                description: "Writing\nto Firestore",
                systemImageName: "externaldrive.fill.badge.icloud",
                effect: .pulse,
                behavior: .repeat(.continuous)
            )
        case .completed:
            return .init(
                type: self,
                description: "Upload\nSuccessful",
                systemImageName: "checkmark.circle.fill",
                effect: .bounce,
                behavior: .nonRepeating
            )
        }
    }
}

struct AvatarIconsUploadProgressModel {
    let type: AvatarIconsUploadProgressTypes
    let description: String
    let systemImageName: String
    let effect: AvatarIconUploadProgressEffectTypes
    let behavior: SymbolEffectOptions
}

enum AvatarIconUploadProgressEffectTypes {
    case wiggle, rotate, pulse, bounce
}
