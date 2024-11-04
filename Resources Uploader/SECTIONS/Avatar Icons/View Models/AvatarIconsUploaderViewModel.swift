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
    let progressTypesArray: [AvatarIconsUploadProgressTypes] = AvatarIconsUploadProgressTypes.allCases
    
    // MARK: - INITIALIZER
    init() { }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getAvatarCount
    private func setAvatarCount() {
        avatarCount = selectedItems.count
    }
    
    func upload() {
        // TODO: upload to firebase storage code goes here...
        
        
#if DEBUG
        // mock
        guard let selectedProgressType = selectedProgressType else {
            selectedProgressType = .uploading_1
            return
        }
        
        guard let index: Int = progressTypesArray.firstIndex(of: selectedProgressType),
              index != progressTypesArray.count-1 else {
            self.selectedProgressType = nil
            return
        }
        
        self.selectedProgressType = progressTypesArray[index+1]
#endif
    }
}
