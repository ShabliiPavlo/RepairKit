//
//  OnboardingScreen.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit

enum OnboardingScreen: Int, CaseIterable {
    case welcome
    case popularType
    case appInfo
    case manageApp
    case getResults
}

extension OnboardingScreen {
    var title: String {
        switch self {
        case .welcome:
            String(localized: "onboarding.welcome_title")
        case .popularType:
            String(localized: "onboarding.type_title")
        case .appInfo:
            String(localized: "onboarding.info_title")
        case .manageApp:
            String(localized: "onboarding.manage_title")
        case .getResults:
            String(localized: "onboarding.result_title")
        }
    }
    
    var text: String {
        switch self {
        case .welcome:
            String(localized: "onboarding.welcome_text")
        case .popularType:
            String(localized: "onboarding.type_text")
        case .appInfo:
            String(localized: "onboarding.info_text")
        case .manageApp:
            String(localized: "onboarding.manage_text")
        case .getResults:
            String(localized: "onboarding.result_text")
        }
    }
    
    var image: UIImage {
        switch self {
        case .welcome:
            UIImage(resource: .onboardingWelcome)
        case .popularType:
            UIImage(resource: .onboardingPopular)
        case .appInfo:
            UIImage(resource: .onboardingEnter)
        case .manageApp:
            UIImage(resource: .onboardingCollectData)
        case .getResults:
            UIImage(resource: .onboardingResults)
        }
    }
    
    var isLast: Bool {
        switch self {
        case .getResults:
            true
        default:
            false
        }
    }
}

