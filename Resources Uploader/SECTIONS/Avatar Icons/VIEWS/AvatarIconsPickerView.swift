//
//  AvatarIconsPickerView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI
import PhotosUI

struct AvatarIconsPickerView: View {
    // MARK: - PROPERTIES
    @Bindable var vm: AvatarIconsUploaderViewModel
    
    // MARK: - INITIALIZER
    init(vm: AvatarIconsUploaderViewModel) {
        self.vm = vm
    }
    
    // MARK: - BODY
    var body: some View {
        Section {
            PhotosPicker(
                selection: $vm.selectedItems,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Select Avatars")
            }
            .onChange(of: vm.selectedItems) { _, newItems in
                vm.selectedImages = []
                
                for item in newItems {
                    Task {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            vm.selectedImages.append(uiImage)
                        }
                    }
                }
            }
        } footer : {
            Text("Multiple icons can be selected.")
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarIconsPickerView") {
    @Previewable @State var vm: AvatarIconsUploaderViewModel = .init()
    AvatarIconsPickerView(vm: vm)
}
