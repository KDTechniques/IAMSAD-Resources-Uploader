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
    @State private var isPresentedPhototPicker: Bool = false
    
    // MARK: - INITIALIZER
    init(vm: AvatarIconsUploaderViewModel) {
        self.vm = vm
    }
    
    // MARK: - BODY
    var body: some View {
        Section {
            Button("Select Avatars") {
                isPresentedPhototPicker = true
            }
            .sheet(isPresented: $isPresentedPhototPicker) {
                PhotoPickerView(fileName_ImageDataDictionary: $vm.selectedItems)
                    .ignoresSafeArea()
            }
        } footer : {
            Text("Multiple icons can be selected.")
                .padding(.bottom, 50)
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarIconsPickerView") {
    @Previewable @State var vm: AvatarIconsUploaderViewModel = .init()
    AvatarIconsPickerView(vm: vm)
}
