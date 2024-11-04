//
//  AvatarIconUploadProgressView.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

struct AvatarIconUploadProgressView: View {
    // MARK: - BODY
    var body: some View {
        HStack {
            ForEach(AvatarIconsUploadProgressTypes.allCases, id: \.self) { type in
                AvatarIconUploadProgressItemNArrowView(type: type)
            }
        }
        .padding(.vertical)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarIconUploadProgressView") {
    @Previewable @State var vm: AvatarIconsUploaderViewModel = .init()
    VStack {
        Form {
            Section {
                AvatarIconUploadProgressView()
            } header: {
                Text("Progress")
            }
            .onTapGesture {
                vm.selectedProgressType = AvatarIconsUploadProgressTypes
                    .allCases
                    .randomElement() ?? .uploading_1
            }
        }
        
        // Test Button
        Button("test upload") {
            guard let selectedProgressType = vm.selectedProgressType else {
                vm.selectedProgressType = .uploading_1
                return
            }
            
            guard let index: Int = vm.progressTypesArray.firstIndex(of: selectedProgressType),
                  index != vm.progressTypesArray.count-1 else {
                vm.selectedProgressType = nil
                return
            }
            
            vm.selectedProgressType = vm.progressTypesArray[index+1]
        }
    }
    .environment(vm)
}
