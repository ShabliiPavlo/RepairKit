//
//  ChekEmailCoordinator.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit

final class ChekEmailCoordinator: Coordinator {
    private let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = ChekEmailViewModel()
        let viewController = ChekEmailViewController(viewModel: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
    }
}
