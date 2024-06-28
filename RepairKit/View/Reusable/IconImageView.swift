//
//  IconImageView.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 27.06.2024.
//

import UIKit

final class IconImageView: UIImageView {
    convenience init(image: UIImage) {
        self.init()
        self.image = image
        self.contentMode = .scaleAspectFit
    }
}