//
//  AvatarCollectionDescriptionView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

struct AvatarCollectionDescriptionView: View {
    // MARK: - PROPERTIES
    @Bindable var vm: AvatarIconsUploaderViewModel
    
    // MARK: - INITIALIZER
    init(vm: AvatarIconsUploaderViewModel) {
        self.vm = vm
    }
    
    // MARK: - BODY
    var body: some View {
        Section {
            TextField("Type here", text: $vm.descriptionTextfieldText, axis: .vertical)
        } header: {
            Text("Description")
        } footer: {
            Text("Keep it to max. 2 sentences.")
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarCollectionDescriptionView") {
    @Previewable @State var vm: AvatarIconsUploaderViewModel = .init()
    Form {
        AvatarCollectionDescriptionView(vm: vm)
    }
}
