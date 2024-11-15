//
//  PhotoPickerView.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-13.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: UIViewControllerRepresentable {
    // MARK: - PROPERTIES
    @Binding var fileName_ImageDataDictionary: [String : Data]
    
    // MARK: - INITIALIZER
    init(fileName_ImageDataDictionary: Binding<[String : Data]>) {
        _fileName_ImageDataDictionary = fileName_ImageDataDictionary
    }
    
    // MARK: - COORDINATOR
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        // MARK: - PROPERTIES
        var parent: PhotoPickerView
        
        // MARK: - INITIALIZER
        init(parent: PhotoPickerView) {
            self.parent = parent
        }
        
        // MARK: FUNCTIONS
        
        // MARK: - getFileName
        private func getFileName(_ result: PHPickerResult) async throws -> String {
            try await withCheckedThrowingContinuation { continuation in
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                    if let error = error {
                        print("Error occurred while loading file URLs in Photo Picker: \(error.localizedDescription)")
                        continuation.resume(throwing: error)
                    } else if let url = url {
                        print(url.lastPathComponent)
                        continuation.resume(returning: url.lastPathComponent)
                    } else {
                        continuation.resume(throwing: NSError(domain: "Unknown error", code: -1, userInfo: nil))
                    }
                }
            }
        }
        
        // MARK: - getImageData
        private func getImageData(_ result: PHPickerResult) async throws -> Data {
            try await withCheckedThrowingContinuation { continuation in
                result.itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { data, error in
                    if let error = error {
                        print("Error occurred while loading data in Photo Picker: \(error.localizedDescription)")
                        continuation.resume(throwing: error)
                    } else if let data = data {
                        continuation.resume(returning: data)
                    } else {
                        continuation.resume(throwing: NSError(domain: "Unknown error", code: -1, userInfo: nil))
                    }
                }
            }
        }
        
        // MARK: - picker
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            for result in results {
                if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    Task { @MainActor [weak self] in
                        guard let self else { return }
                        do {
                            let fileName = try await getFileName(result)
                            let imageData = try await getImageData(result)
                            parent.fileName_ImageDataDictionary[fileName] = imageData
                        } catch {
                            print("Error processing picker result: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - makeCoordinator
    func makeCoordinator() -> Coordinator {
        .init(parent: self)
    }
    
    // MARK: - makeUIViewController
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0 // Allow multiple selections
        configuration.selection = .ordered
        configuration.preferredAssetRepresentationMode = .current
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    // MARK: - updateUIViewController
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
}
