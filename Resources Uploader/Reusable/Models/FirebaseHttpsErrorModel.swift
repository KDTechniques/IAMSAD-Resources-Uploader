//
//  HttpsErrorModel.swift
//  Resources Uploader
//
//  Created by Kavinda Dilshan on 2024-11-16.
//

import Foundation

struct FirebaseHttpsErrorModel {
    let codeDescription: String
    let message: String
    let details: String
}

enum FirebaseFunctionsErrorCode: Int {
    case OK = 0
    case cancelled = 1
    case unknown = 2
    case invalidArgument = 3
    case deadlineExceeded = 4
    case notFound = 5
    case alreadyExists = 6
    case permissionDenied = 7
    case resourceExhausted = 8
    case failedPrecondition = 9
    case aborted = 10
    case outOfRange = 11
    case unimplemented = 12
    case `internal` = 13
    case unavailable = 14
    case dataLoss = 15
    case unauthenticated = 16
    
    var codeDescription: String {
        switch self {
        case .OK:
            return "The operation completed successfully."
        case .cancelled:
            return "The operation was cancelled (typically by the caller)."
        case .unknown:
            return "Unknown error or an error from a different error domain."
        case .invalidArgument:
            return "Client specified an invalid argument."
        case .deadlineExceeded:
            return "Deadline expired before operation could complete."
        case .notFound:
            return "Some requested document was not found."
        case .alreadyExists:
            return "Some document that we attempted to create already exists."
        case .permissionDenied:
            return "The caller does not have permission to execute the specified operation."
        case .resourceExhausted:
            return "Some resource has been exhausted, perhaps a per-user quota or file system."
        case .failedPrecondition:
            return "Operation was rejected because the system is not in the required state."
        case .aborted:
            return "The operation was aborted, typically due to a concurrency issue."
        case .outOfRange:
            return "Operation was attempted past the valid range."
        case .unimplemented:
            return "Operation is not implemented or not supported/enabled."
        case .internal:
            return "Internal errors. Some invariant expected by the system was broken."
        case .unavailable:
            return "The service is currently unavailable. Retry with backoff."
        case .dataLoss:
            return "Unrecoverable data loss or corruption."
        case .unauthenticated:
            return "The request does not have valid authentication credentials for the operation."
        }
    }
}
