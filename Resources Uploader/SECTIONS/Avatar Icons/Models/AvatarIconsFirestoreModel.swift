//
//  AvatarIconsFirestoreModel.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-15.
//

import Foundation


struct AvatarIconsFirestoreModel {
    let collectionName: String
    let description: String
    let imageFileNamesNData: [String : Data]
    let avatarCount: Int
}
