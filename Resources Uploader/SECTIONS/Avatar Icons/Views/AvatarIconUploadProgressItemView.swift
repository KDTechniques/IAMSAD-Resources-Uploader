//
//  AvatarIconUploadProgressItemView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

struct AvatarIconUploadProgressItemView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarIconsUploaderViewModel.self) private var vm
    let item: AvatarIconsUploadProgressModel
    
    let imageFrameHeight: CGFloat = 30
    
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
        .frame(width: 70)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarIconUploadProgressItemView") {
    @Previewable @State var vm: AvatarIconsUploaderViewModel = .init()
    AvatarIconUploadProgressItemView(item: (vm.selectedProgressType ?? .uploading_1).model)
        .environment(vm)
        .onTapGesture {
            vm.selectedProgressType = .allCases.randomElement() ?? .uploading_1
        }
    
}

// MARK: EXTENSIONS

// MARK: - EXT AvatarIconUploadProgressItemView
extension AvatarIconUploadProgressItemView {
    // MARK: - symbolImage
    private var symbolImage: some View {
        Image(systemName: item.systemImageName)
            .resizable()
            .scaledToFit()
            .frame(width: imageFrameHeight*item.widthRatio, height: imageFrameHeight)
            .offset(y: item.offsetY)
            .foregroundStyle(getForegroundColor())
            .symbolRenderingMode(.hierarchical)
            .setSymbolEffectViewModifier(item, isActive: isActive() && !isInfrontOfType())
    }
    
    // MARK: - descriptionText
    private var descriptionText: some View {
        Text(item.description)
            .font(.caption2)
            .multilineTextAlignment(.center)
            .foregroundStyle(getForegroundColor())
    }
    
    // MARK: FUNCTIONS
    
    // MARK: - isInfrontOfType
    private func isInfrontOfType() -> Bool {
        guard let selectedProgressType: AvatarIconsUploadProgressTypes = vm.selectedProgressType,
              let indexOfType: Int = vm.progressTypesArray.firstIndex(of: item.type),
              let indexOfSelectedType: Int = vm.progressTypesArray.firstIndex(of: selectedProgressType) else {
            return false
        }
        
        return indexOfSelectedType > indexOfType
    }
    
    // MARK: - isActive
    private func isActive() -> Bool {
        return item.type == vm.selectedProgressType?.model.type
        || isInfrontOfType()
    }
    
    // MARK: - getForegroundColor
    private func getForegroundColor() -> Color {
        isActive()
        ? item.type == .completed_4 ? .green : .primary
        : Color(uiColor: .systemGray3)
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
