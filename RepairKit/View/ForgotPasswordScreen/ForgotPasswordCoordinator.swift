//
//  ForgotPasswordCoordinator.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit

final class ForgotPasswordCoordinator: Coordinator {
    enum Path {
        case reset
    }
    
    private let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = ForgotPasswordViewModel() { path in
            switch path {
            case .reset:
                self.startChekEmailFlow()
            }
        }
        let viewController = ForgotPasswordViewController(viewModel: viewModel)
        
        rootViewController.isNavigationBarHidden = true
        rootViewController.setViewControllers([viewController], animated: true)
    }
    
    private func startChekEmailFlow() {
        ChekEmailCoordinator(rootViewController: rootViewController).start()
    }
}

