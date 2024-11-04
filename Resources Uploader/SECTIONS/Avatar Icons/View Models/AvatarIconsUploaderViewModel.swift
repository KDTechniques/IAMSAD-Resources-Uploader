//
//  AvatarIconsUploaderViewModel.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import _PhotosUI_SwiftUI

@MainActor @Observable
final class AvatarIconsUploaderViewModel {
    // MARK: - PROPERTIES
    var collectionNameTextfieldText: String = ""
    var descriptionTextfieldText: String = ""
    var avatarCount: Int = 0
    var selectedItems: [PhotosPickerItem] = [] { didSet { setAvatarCount() } }
    var selectedImages: [UIImage] = []
    var selectedPosition: AvatarPositionTypes = .center
    var selectedProgressType: AvatarIconsUploadProgressTypes?
    
    // MARK: - INITIALIZER
    init() { }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getAvatarCount
    private func setAvatarCount() {
        avatarCount = selectedItems.count
    }
    
    func upload() {
        // TODO: upload to firebase storage code goes here...
    }
    
}
