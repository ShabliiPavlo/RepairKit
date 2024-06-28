//
//  AuthenticationError.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import Foundation

enum AuthenticationError: String {
    case invalidEmail
    case invalidPassword
    case userNameNotFound
    case emailAlreadyExists
}
