//
//  Fonts.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 27.06.2024.
//

import UIKit

enum FontSizes {
    case bigTitle
    case title
    case headline
    case body
    case info
    case caption
    case customSize

    var size: CGFloat {
        switch self {
        case .bigTitle:
            return 32
        case .title:
            return 26
        case .headline:
            return 24
        case .body:
            return 18
        case .info:
            return 16
        case .customSize:
            return 12
        case .caption:
            return 9
        }
    }
}

extension UIFont {
    static func poppinsSemiBold(_ size: FontSizes) -> UIFont {
        UIFont(name: "Poppins-SemiBold", size: size.size) ?? .systemFont(ofSize: size.size, weight: .semibold)
    }
    
    static func poppinsRegular(_ size: FontSizes) -> UIFont {
        UIFont(name: "Poppins-Regular", size: size.size) ?? .systemFont(ofSize: size.size)
    }
    
    static func latoRegular(_ size: FontSizes) -> UIFont {
        UIFont(name: "Lato-Regular", size: size.size) ?? .systemFont(ofSize: size.size)
    }
    
    static func balooThambiRegular(_ size: FontSizes) -> UIFont {
        UIFont(name: "a_BalooThambi-Regular", size: size.size) ?? .systemFont(ofSize: size.size)
    }
}

