//
//  AvatarIconUploadProgressItemNArrowView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

struct AvatarIconUploadProgressItemNArrowView: View {
    // MARK: - PROPERTIES
    let type: AvatarIconsUploadProgressTypes
    
    // MARK: - INITIALIZER
    init(type: AvatarIconsUploadProgressTypes) {
        self.type = type
    }
    
    // MARK: - BODY
    var body: some View {
        HStack {
            AvatarIconUploadProgressItemView(item: type.model)
            arrowIcon(type: type)
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarIconUploadProgressItemNArrowView") {
    @Previewable @State var vm: AvatarIconsUploaderViewModel = .init()
    AvatarIconUploadProgressItemNArrowView(type: vm.selectedProgressType ?? .uploading_1)
        .environment(vm)
        .onTapGesture {
            vm.selectedProgressType = .allCases.randomElement() ?? .uploading_1
        }
}

// MARK: - EXTENSIONS
extension AvatarIconUploadProgressItemNArrowView {
    // MARK: - arrowIcon
    @ViewBuilder
    private func arrowIcon(type: AvatarIconsUploadProgressTypes) -> some View {
        if AvatarIconsUploadProgressTypes.allCases.last != type {
            Image(systemName: "arrow.right")
                .foregroundStyle(Color(uiColor: .systemGray4))
        }
    }
}
