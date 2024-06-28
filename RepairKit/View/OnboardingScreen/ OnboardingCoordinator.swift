//
//   OnboardingCoordinator.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit

final class OnboardingCoordinator: Coordinator {
    enum Path {
        case main
    }

    private let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        let viewModel = OnboardingViewModel() { path in
            switch path {
            case .main:
                self.startMainFlow()
            }
        }
        let viewController = OnboardingViewController(viewModel: viewModel)

        rootViewController.pushViewController(viewController, animated: true)
    }

    private func startMainFlow() {
        MainCoordinator(rootViewController: rootViewController).start()
    }
}
