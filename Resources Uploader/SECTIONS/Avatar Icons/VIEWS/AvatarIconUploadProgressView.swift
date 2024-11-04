//
//  AvatarIconUploadProgressView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

struct AvatarIconUploadProgressView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarIconsUploaderViewModel.self) private var vm
    let item: AvatarIconsUploadProgressModel
    
    // MARK: - INITIALIZER
    init(item: AvatarIconsUploadProgressModel) {
        self.item = item
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            symbolImage
            descriptionText
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarIconUploadProgressView") {
    @Previewable @State var vm: AvatarIconsUploaderViewModel = .init()
    AvatarIconUploadProgressView(item: (vm.selectedProgressType ?? AvatarIconsUploadProgressTypes.uploading).model)
        .environment(vm)
        .onTapGesture {
            vm.selectedProgressType = AvatarIconsUploadProgressTypes.allCases.randomElement() ?? .uploading
        }
    
}

// MARK: EXTENSIONS

// MARK: - EXT AvatarIconUploadProgressView
extension AvatarIconUploadProgressView {
    // MARK: - symbolImage
    private var symbolImage: some View {
        Image(systemName: item.systemImageName)
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundStyle(getForegroundColor())
            .symbolRenderingMode(.hierarchical)
            .setSymbolEffectViewModifier(item, isActive: isActive())
    }
    
    // MARK: - descriptionText
    private var descriptionText: some View {
        Text(item.description)
            .font(.caption2)
            .multilineTextAlignment(.center)
            .foregroundStyle(getForegroundColor())
    }
    
    // MARK: FUNCTIONS
    
    // MARK: - isActive
    private func isActive() -> Bool {
        return item.type == vm.selectedProgressType?.model.type
    }
    
    // MARK: - getForegroundColor
    private func getForegroundColor() -> Color {
        isActive()
        ? item.type == .completed ? .green : .white
        : .secondary
    }
}

// MARK: - View
fileprivate extension View {
    // MARK: - FUNCTIONS
    
    // MARK: - EXT setSymbolEffectViewModifier
    @ViewBuilder
    func setSymbolEffectViewModifier(_ item: AvatarIconsUploadProgressModel, isActive: Bool) -> some View {
        switch item.effect {
        case .bounce:
            self.symbolEffect(.bounce, options: item.behavior, isActive: isActive)
        case .wiggle:
            self.symbolEffect(.wiggle, options: item.behavior, isActive: isActive)
        case .rotate:
            self.symbolEffect(.rotate, options: item.behavior, isActive: isActive)
        case .pulse:
            self.symbolEffect(.pulse, options: item.behavior, isActive: isActive)
        }
    }
}
