//
//  SignUpViewModel.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import Foundation

protocol SignUpViewModelProtocol {
    var showError: ((AuthenticationError) -> Void)? { get set }
    func signUp(account: Account, completion: @escaping () -> Void)
    func loginButtonPressed()
}

final class SignUpViewModel: SignUpViewModelProtocol {
    
    typealias PathAction = (SignUpCoordinator.Path) -> Void
    var showError: ((AuthenticationError) -> Void)?
    
    private let pathAction: PathAction
    private let authenticationService: AuthenticationServiceProtocol
    
    init(pathAction: @escaping PathAction, authenticationService: AuthenticationServiceProtocol) {
        self.pathAction = pathAction
        self.authenticationService = authenticationService
    }
    
    func signUp(account: Account, completion: @escaping () -> Void) {
        var errorAppears = false
        
        if !account.mail.isValidEmail {
            showError?(.invalidEmail)
            errorAppears = true
        }
        
        if !account.password.isValidPassword {
            showError?(.invalidPassword)
            errorAppears = true
        }
        
        if !errorAppears {
            authenticationService.signUp(account: account) { success in
                completion()
                if success {
                    self.pathAction(.onboarding)
                } else {
                    self.showError?(.emailAlreadyExists)
                }
            }
        } else {
            completion()
        }
    }
    
    func loginButtonPressed() {
        pathAction(.login)
    }
}

