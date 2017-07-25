//
//  Error.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-15.
//  Copyright © 2017 xTech. All rights reserved.
//

import Foundation

extension CustomFirebaseError : LocalizedError {
    public var errorDescription: String? {
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
    public var errorDescription: String? {
        switch self {
        case .cannotRetrieveData:
            return "DATA_NOT_FETCHED".localized()
        case .invalidDataFormat:
            return "INVALID_DATA_FORMAT".localized()
        }
    }
}

