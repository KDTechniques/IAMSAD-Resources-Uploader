//
//  Resources_UploaderApp.swift
//  Resources Uploader
//
//  Created by Mr. Kavinda Dilshan on 2024-11-04.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Resources_UploaderApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            AvatarIconsUploaderFormView()
            TestingCloudFunctionsView()
        }
    }
}
