//
//   MainCoordinator.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit

final class MainCoordinator: Coordinator {
    private let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
    }
}
