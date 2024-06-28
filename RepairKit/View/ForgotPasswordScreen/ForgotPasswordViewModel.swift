//
//  ForgotPasswordViewModel.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit

protocol ForgotPasswordViewModelProtocol {
    var validateEmail: ((Bool) -> Void)? { get set }
    func updateEmail(_ email: String)
    func textFieldDidChange(text: String)
    func resetPassword()
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    typealias PathAction = (ForgotPasswordCoordinator.Path) -> Void
    
    var validateEmail: ((Bool) -> Void)?
    
    private let pathAction: PathAction
    
    init(pathAction: @escaping PathAction) {
        self.pathAction = pathAction
    }
    
    func updateEmail(_ email: String) {
         validateEmail?(email.isValidEmail)
    }
    
    func textFieldDidChange(text: String) {
            updateEmail(text)
        }
    
    func resetPassword() {
        pathAction(.reset)
    }
}

