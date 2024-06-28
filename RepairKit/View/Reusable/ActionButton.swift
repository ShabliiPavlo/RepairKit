//
//  ActionButton.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 27.06.2024.
//

import UIKit

class ActionButton: UIButton {
    let actionButtonHeight = 52.0
    
    convenience init(title: String, style: ButtonStyle, action: UIAction? = nil) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(style.titleColor, for: .normal)
        self.titleLabel?.font = style.font
        self.backgroundColor = style.backgroundColor
        self.layer.cornerRadius = style.cornerRadius
        if let action = action {
                self.addAction(action, for: .touchUpInside)
            }
    }
}

extension ActionButton {
    struct ButtonStyle {
        let titleColor: UIColor
        let font: UIFont
        let backgroundColor: UIColor
        let cornerRadius: CGFloat

        static let actionButton = ButtonStyle(
            titleColor: .white,
            font: .poppinsSemiBold(.body),
            backgroundColor: .primaryGreen,
            cornerRadius: .mediumRadius
        )

        static let infoButton = ButtonStyle(
            titleColor: .primaryGreen,
            font: .poppinsRegular(.info),
            backgroundColor: .clear,
            cornerRadius: 0
        )

        static let privacyPolicyButton = ButtonStyle(
            titleColor: .primaryGreen,
            font: .poppinsRegular(.caption),
            backgroundColor: .clear,
            cornerRadius: 0
        )
        
        func update(
            titleColor: UIColor? = nil,
            font: UIFont? = nil,
            backgroundColor: UIColor? = nil,
            cornerRadius: CGFloat? = nil
        ) -> ButtonStyle {
            ButtonStyle(
                titleColor: titleColor ?? self.titleColor,
                font: font ?? self.font,
                backgroundColor: backgroundColor ?? self.backgroundColor,
                cornerRadius: cornerRadius ?? self.cornerRadius
            )
        }
    }
}
