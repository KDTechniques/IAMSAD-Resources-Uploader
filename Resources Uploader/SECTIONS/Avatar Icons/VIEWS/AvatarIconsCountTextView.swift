//
//  AvatarIconsCountTextView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

struct AvatarIconsCountTextView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarIconsUploaderViewModel.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        Section {
            Text("Avatar count: \(vm.avatarCount)")
        } footer: {
            Text("Avatar count is automated on number of avatar images you select.")
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarIconsCountTextView") {
    Form {
        AvatarIconsCountTextView()
    }
    .environment(AvatarIconsUploaderViewModel())
}
