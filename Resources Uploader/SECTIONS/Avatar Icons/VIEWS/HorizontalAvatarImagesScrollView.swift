//
//  HorizontalAvatarImagesScrollView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

struct HorizontalAvatarImagesScrollView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarIconsUploaderViewModel.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if vm.selectedImages.isEmpty {
                    ForEach(0...10, id: \.self) { _ in
                        Circle()
                            .foregroundStyle(Color(uiColor: .systemGray5))
                            .frame(
                                width: 50,
                                height: 50,
                                alignment: vm.selectedPosition == .bottom ? .bottom : .center
                            )
                    }
                } else {
                    ForEach(vm.selectedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: getAlignment())
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("HorizontalAvatarImagesScrollView") {
    HorizontalAvatarImagesScrollView()
}

extension HorizontalAvatarImagesScrollView {
    // MARK: - FUNCTIONS
    
    // MARK: - getAlignment
    private func getAlignment() -> Alignment {
        switch vm.selectedPosition {
        case .bottom:
            return .bottom
        case .center:
            return .center
        }
    }
}
