//
//  LogoView.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 27.06.2024.
//

import UIKit

class LogoView: UIView {
    private let iconImageView: IconImageView
    private let titleLabel: TitleLabel

    init(icon: UIImage, title: String, style: TitleLabel.Style) {
        self.iconImageView = IconImageView(image: icon)
        self.titleLabel = TitleLabel(text: title, style: style)
        super.init(frame: .zero)

        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.height.equalTo(80)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.trailing.equalTo(iconImageView.snp.leading).offset(Layout.horizontalSpacing)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Layout {
        static let horizontalSpacing: Float = 4

    }
}
