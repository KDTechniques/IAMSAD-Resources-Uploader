//
//  AvatarImagePositionPickerView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

struct AvatarImagePositionPickerView: View {
    // MARK: - PROPERTIES
    @Bindable var vm: AvatarIconsUploaderViewModel
    
    // MARK: - INITIALIZER
    init(vm: AvatarIconsUploaderViewModel) {
        self.vm = vm
    }
    
    // MARK: - BODY
    var body: some View {
        Picker("Avatar Image Position", selection: $vm.selectedPosition) {
            Text("Bottom")
                .tag(AvatarPositionTypes.bottom)
            
            Text("Center")
                .tag(AvatarPositionTypes.center)
        }
        .pickerStyle(.segmented)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarImagePositionPickerView") {
    @Previewable @State var vm: AvatarIconsUploaderViewModel = .init()
    AvatarImagePositionPickerView(vm: vm)
}
