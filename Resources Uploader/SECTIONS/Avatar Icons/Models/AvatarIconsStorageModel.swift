//
//  AvatarIconsStorageModel.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-15.
//

import Foundation

struct AvatarIconsStorageModel {
    let bucketURL: String
    let folderName: String
    let imageData: [AvatarIconsStorageImageDataModel]
}

struct AvatarIconsStorageImageDataModel {
    let fileName: String
    let fileExtension: String
    let data: Data
}
