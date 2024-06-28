//
//  OnboardingViewModel.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit

protocol OnboardingViewModelProtocol {
    var maxNumberOfPages: Int { get }
    var upateScreen: ((OnboardingScreen) -> Void)? { get set }
    
    func actionButtonPressed()
    func setupFirstScreen()
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    typealias PathAction = (OnboardingCoordinator.Path) -> Void
    
    var maxNumberOfPages = OnboardingScreen.allCases.count
    var upateScreen: ((OnboardingScreen) -> Void)?

    private var currentScreen: OnboardingScreen = .welcome
    private let pathAction: PathAction

    init(pathAction: @escaping PathAction) {
        self.pathAction = pathAction
        upateScreen?(currentScreen)
    }
    
    func actionButtonPressed() {
        if currentScreen.rawValue == OnboardingScreen.allCases.count - 1 {
            pathAction(.main)
        } else {
            guard let nextScreen = OnboardingScreen(rawValue: currentScreen.rawValue + 1) else {
                // TODO: - Handle this case
                return
            }
            
            upateScreen?(nextScreen)
            currentScreen = nextScreen
        }
    }
    
    func setupFirstScreen() {
        upateScreen?(currentScreen)
    }
}
