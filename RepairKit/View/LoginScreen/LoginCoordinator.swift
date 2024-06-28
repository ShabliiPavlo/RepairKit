//
//  LoginCoordinator.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 24.06.2024.
//

import UIKit

final class LoginCoordinator: Coordinator {
    enum Path {
        case signUp
        case forgotPassword
        case main
    }

    private let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
           let authenticationService = AuthenticationService()

           let viewModel = LoginViewModel(pathAction: { path in
               switch path {
               case .signUp:
                   self.startSignUpFlow()
               case .forgotPassword:
                   self.startForgotPasswordFlow()
               case .main:
                   self.startMainFlow()
               }
           }, authenticationService: authenticationService)
           
           let viewController = LoginViewController(viewModel: viewModel)
           
           rootViewController.isNavigationBarHidden = true
           rootViewController.setViewControllers([viewController], animated: true)
       }
    
    private func startSignUpFlow() {
        SignUpCoordinator(rootViewController: rootViewController).start()
    }
    
    private func startForgotPasswordFlow() {
        ForgotPasswordCoordinator(rootViewController: rootViewController).start()
    }
    
    private func startMainFlow() {
        MainCoordinator(rootViewController: rootViewController).start()
    }
}

