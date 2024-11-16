//
//  TestingCloudFunctionsView.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-16.
//

import SwiftUI
import FirebaseFunctions

struct TestingCloudFunctionsView: View {
    let functions = Functions.functions()
    var body: some View {
        Button("Test 1") {
            Task {
                do {
                    let payload: [String: Any] = ["text": "Hello"]
                    // Call the cloud function
                    let response = try await functions.httpsCallable("helloWorld").call()
                    if let data = response.data as? [String: Any],
                       let successMessage = data["isCompleted"] as? String {
                        print("Function Response: \(successMessage)")
                    } else {
                        print("Unexpected response format: \(response.data)")
                    }
                } catch {
                   print(Helpers.getFirebaseHttpsError(error) ?? "Can't parse error")
                }
            }
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
}

#Preview {
    TestingCloudFunctionsView()
}
