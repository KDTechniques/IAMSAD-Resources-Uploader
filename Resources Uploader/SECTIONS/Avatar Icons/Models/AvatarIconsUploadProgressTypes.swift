//
//  AvatarIconsUploadProgressTypes.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import Foundation
import Symbols

enum AvatarIconsUploadProgressTypes: CaseIterable {
    // NOTE: Please maintain the processing order
    case uploading_1, processing_2, writing_3, completed_4
    
    var model: AvatarIconsUploadProgressModel {
        switch self {
        case .uploading_1:
            return .init(
                type: self,
                description: "Uploading\nto Storage",
                systemImageName: "icloud.and.arrow.up.fill",
                effect: .wiggle,
                behavior: .repeat(.continuous),
                widthRatio: 13/15,
                offsetY: 2
            )
        case .processing_2:
            return .init(
                type: self,
                description: "Processing\nData",
                systemImageName: "arrow.trianglehead.2.clockwise.rotate.90.icloud.fill",
                effect: .rotate,
                behavior: .repeat(.continuous),
                widthRatio: 13/15,
                offsetY: -0.5
            )
        case .writing_3:
            return .init(
                type: self,
                description: "Writing\nto Firestore",
                systemImageName: "externaldrive.fill.badge.icloud",
                effect: .pulse,
                behavior: .repeat(.continuous),
                widthRatio: 1,
                offsetY: 1
            )
        case .completed_4:
            return .init(
                type: self,
                description: "Upload\nSuccessful",
                systemImageName: "checkmark.circle.fill",
                effect: .bounce,
                behavior: .nonRepeating,
                widthRatio: 2/3,
                offsetY: -0.5
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
    let widthRatio: CGFloat
    let offsetY: CGFloat
}

enum AvatarIconUploadProgressEffectTypes {
    case wiggle, rotate, pulse, bounce
}
