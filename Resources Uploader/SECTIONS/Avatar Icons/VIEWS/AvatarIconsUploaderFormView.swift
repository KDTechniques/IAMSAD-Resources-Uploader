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
            Form {
                Section {
                    // here...
                } header: {
                    Text("Progress")
                }
                
                // Collection Name
                Section {
                    TextField("Type here", text: $vm.collectionNameTextfieldText)
                } header: {
                    Text("Collection Name")
                } footer: {
                    Text("Keep it short. ex: Featured, Super Heroes.")
                }
                
                // Description
                Section {
                    TextField("Type here", text: $vm.descriptionTextfieldText, axis: .vertical)
                } header: {
                    Text("Description")
                } footer: {
                    Text("Keep it to max. 2 sentences.")
                }
                
                // Avatar Count
                Section {
                    Text("Avatar count: \(vm.avatarCount)")
                } footer: {
                    Text("Avatar count is based on number of avatar images you select.")
                }
                
                // Image Preview
                Section {
                    AvatarImagePositionPickerView(vm: vm)
                    HorizontalAvatarImagesScrollView()
                } header: {
                    Text("Avatar Preview")
                } footer: {
                    Text("Use segment picker to find the best image position for the collection.")
                }
                
                AvatarIconsPickerView(vm: vm)
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
    // MARK: - uploadButton
    private var uploadButton: some View {
        Button("Upload") {
            vm.upload()
        }
        .bold()
    }
}
