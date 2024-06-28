//
//  SignUpCoordinator.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 27.06.2024.
//

import UIKit

final class SignUpCoordinator: Coordinator {
    enum Path {
        case login
        case onboarding
        case main
    }

    private let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
            let authenticationService = AuthenticationService()
            
            let viewModel = SignUpViewModel(pathAction: { path in
                switch path {
                case .login:
                    self.startLoginFlow()
                case .onboarding:
                    self.startOnboardingFlow()
                case .main:
                    self.startMainFlow()
                }
            }, authenticationService: authenticationService)
            
            let viewController = SignUpViewController(viewModel: viewModel)
            
            rootViewController.isNavigationBarHidden = true
            rootViewController.setViewControllers([viewController], animated: true)
        }
    
    private func startOnboardingFlow() {
        OnboardingCoordinator(rootViewController: rootViewController).start()
    }
    
    private func startLoginFlow() {
        LoginCoordinator(rootViewController: rootViewController).start()
    }
    
    private func startMainFlow() {
        MainCoordinator(rootViewController: rootViewController).start()
    }
}
