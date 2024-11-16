//
//  Global Helpers.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-15.
//

import Foundation
import FirebaseFunctions

struct Helpers {
    // MARK: - extractFileExtension
    /// This function extracts the file extension from a given file name (or URL).
    /// It returns the file extension as a string if the file name is valid, or `nil` if the file name is invalid or doesn't have an extension.
    /// - Parameter fileName: A string representing the file name or URL.
    /// - Returns: The file extension as a string if available, or `nil` if the extension can't be extracted.
    static func extractFileExtension(_ fileName: String) -> String? {
        if let fileExtension = URL(string: fileName)?.pathExtension {
            return fileExtension
        } else {
            return nil
        }
    }
    
    // MARK: - getFirebaseHttpsError
    /// This function takes an error returned from a Firebase Cloud Function call, processes it,
    /// and returns a structured model that contains the error details, including the error code description,
    /// message, and any additional details provided by Firebase.
    /// - Parameter error: The `Error` object returned from the Firebase Cloud Function call.
    /// - Returns: A `FirebaseHttpsErrorModel` containing the error details or `nil` if the error is not related
    ///   to a Firebase function call.
    static func getFirebaseHttpsError(_ error: Error) -> FirebaseHttpsErrorModel? {
        // Check if the error is a Firebase Function error by examining the domain.
        guard let error = error as NSError?,
              error.domain == FunctionsErrorDomain else { return nil }
        
        // Extract the error code (raw integer value) from the error object.
        let code = error.code
        
        // Get the localized error message that describes what went wrong.
        let message = error.localizedDescription
        
        // Extract additional error details from the userInfo dictionary if available, or use a default message.
        let details = error.userInfo[FunctionsErrorDetailsKey] as? String ?? "No error details available."
        
        // Map the error code to a human-readable description using the FirebaseFunctionsErrorCode enum.
        // If the error code is not recognized, use a default "Unknown error code" message.
        let codeDescription = FirebaseFunctionsErrorCode(rawValue: code)?.codeDescription ?? "Unknown error code."
        
        // Create and return a model that contains the error code description, message, and details.
        let model: FirebaseHttpsErrorModel = .init(
            codeDescription: codeDescription,
            message: message,
            details: details
        )
        return model
    }
    
}
