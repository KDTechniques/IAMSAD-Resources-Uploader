//
//  AvatarCollectionNameView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

struct AvatarCollectionNameView: View {
    // MARK: - PROPERTIES
    @Bindable var vm: AvatarIconsUploaderViewModel
    
    // MARK: - INITIALIZER
    init(vm: AvatarIconsUploaderViewModel) {
        self.vm = vm
    }
    
    // MARK: - BODY
    var body: some View {
        Section {
            TextField("Type here", text: $vm.collectionNameTextfieldText)
        } header: {
            Text("Collection Name")
        } footer: {
            Text("Keep it short. ex: Featured, Super Heroes.")
        }
        .onChange(of: vm.collectionNameTextfieldText) { _, newValue in
            vm.onCollectionNameTextfieldTextChange(newValue)
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarCollectionNameView") {
    @Previewable @State var vm: AvatarIconsUploaderViewModel = .init()
    Form {
        AvatarCollectionNameView(vm: vm)
    }
}
