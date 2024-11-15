//
//  AvatarIconsStorageBucketPickerView.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-15.
//

import SwiftUI

struct AvatarIconsStorageBucketPickerView: View {
    // MARK: - PROPERTIES
    @Bindable var vm: AvatarIconsUploaderViewModel
    
    // MARK: - INITIALIZER
    init(vm: AvatarIconsUploaderViewModel) {
        self.vm = vm
    }
    
    // MARK: - BODY
    var body: some View {
        Section {
            Picker("Avatar Icons Storage Bucket Type", selection: $vm.selectedBucketType) {
                ForEach(BucketTypes.allCases, id: \.self) { bucket in
                    Text(bucket.rawValue)
                        .id(bucket)
                }
            }
            .pickerStyle(.segmented)
        } header: {
            Text("Storage Bucket Type")
        } footer: {
            Text("**Note:** Be careful when making changes to the 'Production' environment.")
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarIconsStorageBucketPickerView") {
    Form {
        AvatarIconsStorageBucketPickerView(vm: .init())
    }
}
