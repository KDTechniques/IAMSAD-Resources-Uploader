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
    var selectedItems: [String:Data] = [:] { didSet { setAvatarCount() } }
    @ObservationIgnored var selectedImages: [UIImage] {
        return selectedItems.values.compactMap { data in
            UIImage(data: data)
        }
    }
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
    
    // MARK: - collectionNameValidation
    private func collectionNameValidation() -> Bool {
        return !collectionNameTextfieldText.isEmpty
    }
    
    // MARK: - descriptionValidation
    private func descriptionValidation() -> Bool {
        return !descriptionTextfieldText.isEmpty
    }
    
    // MARK: - avatarCountValidation
    private func avatarCountValidation() -> Bool {
        return avatarCount != 0
    }
    
    // MARK: - ImageValidation
    private func ImageValidation() -> Bool {
        !selectedItems.isEmpty
    }
    
    // MARK: - formValidation
    private func formValidation() -> Bool {
        guard collectionNameValidation(),
              descriptionValidation(),
              avatarCountValidation() else { return false }
        return true
    }
    
    // MARK: - upload
    func upload() {
        // TODO: upload to firebase storage code goes here...
        guard formValidation() else {
            // Show an alert here...
            print("Form validation failed!")
            return
        }
        
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
