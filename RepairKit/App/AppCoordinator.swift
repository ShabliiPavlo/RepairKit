//
//  AppCoordinator.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 24.06.2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    
    private let rootViewController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = rootViewController
    }
    
    func start() {
        LoginCoordinator(rootViewController: rootViewController).start()
    }
}

