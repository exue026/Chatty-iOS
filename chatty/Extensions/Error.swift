//
//  Error.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-15.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation

enum BaseError: LocalizedError {
    case unknownError
    case optionalUnwrapError
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "UNKNOWN_ERROR".localized()
            
        case .optionalUnwrapError:
            return "OPTIONAL_UNWRAP_ERROR".localized()
        }
    }
}

extension CustomFirebaseError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .blankFields:
            return "LOGIN_BLANK_FIELDS".localized()
        case .emailNotVerified:
            return "EMAIL_UNVERIFIED".localized()
        case .unknownError:
            return "UNKNOWN_ERROR".localized()
        }
    }
}

extension CustomAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cannotRetrieveData:
            return "DATA_NOT_FETCHED".localized()
        case .invalidDataFormat:
            return "INVALID_DATA_FORMAT".localized()
        case .requestTimeout:
            return "REQUEST_TIMEOUT".localized()
        }
    }
}

