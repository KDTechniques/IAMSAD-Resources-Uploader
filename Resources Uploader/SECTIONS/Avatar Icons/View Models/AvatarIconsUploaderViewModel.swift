//
//  AvatarIconsUploaderViewModel.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI
import FirebaseFunctions

@MainActor @Observable
final class AvatarIconsUploaderViewModel {
    // MARK: - PROPERTIES
    var selectedBucketType: BucketTypes = .mockTesting
    var collectionNameTextfieldText: String = ""
    var descriptionTextfieldText: String = ""
    var avatarCount: Int = 0
    var selectedItems: [String : Data] = [:] { didSet { setAvatarCount() } }
    @ObservationIgnored var selectedImages: [UIImage] {
        return selectedItems.values.compactMap { data in
            UIImage(data: data)
        }
    }
    var selectedPosition: AvatarPositionTypes = .center
    var selectedProgressType: AvatarIconsUploadProgressTypes?
    let progressTypesArray: [AvatarIconsUploadProgressTypes] = AvatarIconsUploadProgressTypes.allCases
    @ObservationIgnored lazy var functions = Functions.functions()

    // MARK: - INITIALIZER
    init() { }
    
    // MARK: FUNCTIONS
    
    // MARK: - onCollectionNameTextfieldTextChange
    func onCollectionNameTextfieldTextChange(_ newValue: String) {
        collectionNameTextfieldText = newValue.capitalized
    }
    
    // MARK: - getAvatarCount
    private func setAvatarCount() {
        avatarCount = selectedItems.count
    }
    
    // MARK: - collectionNameValidation
    private func collectionNameValidation() -> Bool {
        let condition1: Bool = collectionNameTextfieldText.capitalized == collectionNameTextfieldText
        let condition2: Bool = !collectionNameTextfieldText.isEmpty
        return condition1 && condition2
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
    
    // MARK: - imageFileExtensionValidation
    private func imageFileExtensionValidation() -> Bool {
        for imageItem in selectedItems {
            let fileName: String = imageItem.key
            guard let _ = Helpers.extractFileExtension(fileName) else { return false }
        }
        return true
    }
    
    // MARK: - formValidation
    private func formValidation() -> Bool {
        guard collectionNameValidation(),
              descriptionValidation(),
              avatarCountValidation(),
              ImageValidation(),
              imageFileExtensionValidation() else { return false }
        return true
    }
    
    // MARK: - createArrayOfImageDataModel
    private func createArrayOfStorageImageDataModel() -> [AvatarIconsStorageImageDataModel] {
        var tempArray: [AvatarIconsStorageImageDataModel] = []
        for (fileName, data) in selectedItems {
            guard let fileExtension: String = Helpers.extractFileExtension(fileName) else { return [] }
            let model: AvatarIconsStorageImageDataModel = .init(
                fileName: fileName,
                fileExtension: fileExtension,
                data: data
            )
            tempArray.append(model)
        }
        return tempArray
    }
    
    // MARK: - createAvatarIconsStorageModelObject
    private func createAvatarIconsStorageModelObject() async -> AvatarIconsStorageModel? {
        let imageDataArray: [AvatarIconsStorageImageDataModel] = createArrayOfStorageImageDataModel()
        guard !imageDataArray.isEmpty else { return nil }
        let storageManager: FirebaseStorageManager = .init(bucket: selectedBucketType)
        let model: AvatarIconsStorageModel = await .init(
            bucketURL: storageManager.getFullReference(to: .avatarIcons).description,
            folderName: collectionNameTextfieldText,
            imageData: imageDataArray
        )
        return model
    }
    
    // MARK: - createAvatarIconsFirestoreModelObject
    private func createAvatarIconsFirestoreModelObject() -> AvatarIconsFirestoreModel {
        let model: AvatarIconsFirestoreModel = .init(
            collectionName: collectionNameTextfieldText,
            description: descriptionTextfieldText,
            imageFileNamesNData: selectedItems,
            avatarCount: avatarCount
        )
        return model
    }
    
    // MARK: - uploadToStorageViaCloudFunction
    private func uploadToStorageViaCloudFunction(_ model: AvatarIconsStorageModel) async {
        let requestData: [String: Any] = [
            "bucketURL": model.bucketURL,
            "AvatarIconsFolderName": model.folderName,
            "imageData": model.imageData
        ]
        
        do {
            // Call the cloud function
            let result = try await functions.httpsCallable("helloWorld").call("Hello")
            if let response = result.data as? [String: Any],
               let successMessage = response["message"] as? String {
                print("Function Response: \(successMessage)")
            }
        } catch {
            print("Error calling function: \(error.localizedDescription)")
        }
    }
    
    // MARK: - upload
    func upload() async {
        // Form Validation
        guard formValidation() else {
            // Show an alert here...
            print("Form validation failed!")
            // show an alert here
            return
        }
        
        // Gather Information to Create Storage Model Object
        guard let model: AvatarIconsStorageModel = await createAvatarIconsStorageModelObject() else {
            print("Error getting 'AvatarIconsStorageModel'")
            // show an alert here or someething...
            return
        }
        
        // Call Cloud Function to Upload Model Data
        await uploadToStorageViaCloudFunction(model)
        
        
        
        // MARK: - Note: the following code can be removed when needed
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
