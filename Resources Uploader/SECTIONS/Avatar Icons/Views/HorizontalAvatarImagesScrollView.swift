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
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if vm.selectedImages.isEmpty {
                    ForEach(0...10, id: \.self) { _ in
                        Circle()
                            .foregroundStyle(Color(uiColor: .systemGray5))
                            .frame(
                                width: 60,
                                height: 60,
                                alignment: vm.selectedPosition == .bottom ? .bottom : .center
                            )
                    }
                } else {
                    ForEach(vm.selectedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: getAlignment())
                            .background(colorScheme == .dark ? .white : Color(uiColor: .systemGray5))
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

// MARK: - PREVIEWS
#Preview("HorizontalAvatarImagesScrollView") {
    HorizontalAvatarImagesScrollView()
        .environment(AvatarIconsUploaderViewModel())
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
