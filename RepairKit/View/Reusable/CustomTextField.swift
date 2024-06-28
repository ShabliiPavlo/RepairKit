//
//  CustomTextField.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 27.06.2024.
//

import UIKit

final class CustomTextField: UITextField {
    convenience init(
        placeholder: String,
        height: Float,
        textContentType: UITextContentType,
        isSecureTextEntry: Bool = false
    ) {
        self.init()
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.additionalGray.withAlphaComponent(0.6),
                .font: UIFont.poppinsRegular(.body)
            ]
        )
        self.textContentType = textContentType
        self.textContentType = .oneTimeCode
        self.borderStyle = .roundedRect
        self.isSecureTextEntry = isSecureTextEntry
        self.defaultTextAttributes = [
                    .foregroundColor: UIColor.black,
                    .font: UIFont.poppinsRegular(.body)
                ]
        self.inputAccessoryView = nil
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
}
