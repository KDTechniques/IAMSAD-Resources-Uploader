//
//  Resources_UploaderApp.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI

@main
struct Resources_UploaderApp: App {
    var body: some Scene {
        WindowGroup {
            AvatarIconsPickerView(vm: .init())
        }
    }
}
