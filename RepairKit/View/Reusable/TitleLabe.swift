//
//  TitleLabe.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 27.06.2024.
//

import UIKit

class TitleLabel: UILabel {
    init(text: String, style: Style) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .left
        self.numberOfLines = 0
        self.textColor = style.textColor
        self.font = style.font
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TitleLabel {
    struct Style {
        let textColor: UIColor
        let font: UIFont
        
        static let bigTitle = Style(
            textColor: .white,
            font:  .balooThambiRegular(.bigTitle)
        )
        
        static let title = Style(
            textColor: .primaryDark,
            font:  .balooThambiRegular(.title)
        )
        
        static let headline = Style(
            textColor: .primaryDark,
            font: .balooThambiRegular(.headline)
        )
        
        static let info = Style(
            textColor: .additionalGray.withAlphaComponent(0.6),
            font: .balooThambiRegular(.info)
        )
        
        static let caption = Style(
            textColor: .additionalGray.withAlphaComponent(0.6),
            font: .balooThambiRegular(.caption)
        )
        
        static let customSize = Style(
            textColor: .additionalRed,
            font: .balooThambiRegular(.customSize)
        )
        
        func update(
            textColor: UIColor? = nil,
            font: UIFont? = nil
        ) -> Style {
            Style(
                textColor: textColor ?? self.textColor,
                font: font ?? self.font
            )
        }
    }
}
