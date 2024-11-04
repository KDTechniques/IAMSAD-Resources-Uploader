//
//  AvatarIconsUploaderFormView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI
import PhotosUI

struct AvatarIconsUploaderFormView: View {
    // MARK: - PROPERTIES
    @State private var vm: AvatarIconsUploaderViewModel = .init()
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress
                AvatarIconUploadProgressView()
                
                Divider()
                
                Form {
                    // Collection Name
                    AvatarCollectionNameView(vm: vm)
                    
                    // Description
                    AvatarCollectionDescriptionView(vm: vm)
                    
                    // Avatar Count
                    AvatarIconsCountTextView()
                    
                    // Image Preview
                    imagePreviewSection
                    
                    // Photo Picker
                    AvatarIconsPickerView(vm: vm)
                }
                .scrollIndicators(.hidden)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    uploadButton
                }
            }
            .navigationTitle("Avatar Icons")
            .environment(vm)
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarIconsUploaderFormView") {
    AvatarIconsUploaderFormView()
}

extension AvatarIconsUploaderFormView {
    // MARK: - imagePreviewSection
    private var imagePreviewSection: some View {
        Section {
            AvatarImagePositionPickerView(vm: vm)
            HorizontalAvatarImagesScrollView()
        } header: {
            Text("Avatar Preview")
        } footer: {
            Text("Use segment picker to find the best image position for the collection.")
        }
    }
    
    // MARK: - uploadButton
    private var uploadButton: some View {
        Button("Upload") {
            vm.upload()
        }
        .bold()
    }
}
