//
//  ForgotPasswordScreen.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 24.06.2024.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var isValidPassword: Bool {
            return self.count >= 8
        }
}
