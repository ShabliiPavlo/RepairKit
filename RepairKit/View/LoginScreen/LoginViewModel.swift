//
//  LoginViewModel.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 24.06.2024.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol LoginViewModelProtocol {
    var chekError: ((AuthenticationError) -> Void)? { get set }
    func login(nickname: String, password: String)
    func signUpButtonPressed()
    func forgotPasswordButtonPressed()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    typealias PathAction = (LoginCoordinator.Path) -> Void
    var chekError: ((AuthenticationError) -> Void)?
    
    private let pathAction: PathAction
    private let authenticationService: AuthenticationServiceProtocol
    
    init(pathAction: @escaping PathAction, authenticationService: AuthenticationServiceProtocol) {
        self.pathAction = pathAction
        self.authenticationService = authenticationService
    }
    
    func login(nickname: String, password: String) {
        if nickname.isValidEmail == false {
            chekError?(.invalidEmail)
            return
        }
        
        if password.isValidPassword == false {
            chekError?(.invalidPassword)
            return
        }
        
        authenticationService.login(nickname: nickname, password: password) { success in
            if success {
                self.pathAction(.main)
            } else {
                self.chekError?(.emailAlreadyExists)
            }
        }
    }
    
    func signUpButtonPressed() {
        pathAction(.signUp)
    }
    
    func forgotPasswordButtonPressed() {
        pathAction(.forgotPassword)
    }
}
