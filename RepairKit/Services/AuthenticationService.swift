//
//  AuthenticationService.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 27.06.2024.
//

import FirebaseAuth
import FirebaseDatabase

protocol AuthenticationServiceProtocol {
    
    func signUp(account: Account, completion: @escaping (Bool) -> Void)
    func login(nickname: String, password: String, completion: @escaping (Bool) -> Void)
}

struct AuthenticationService: AuthenticationServiceProtocol {
    
    func signUp(account: Account, completion: @escaping (Bool) -> Void) {
        
        if account.mail.isValidEmail && account.password.isValidPassword {
            Auth.auth().createUser(withEmail: account.mail, password: account.password) { result, error in
                if let error = error {
                    print("Error creating user: \(error.localizedDescription)")
                    completion(false)
                } else {
                    if let _ = result {
                        completion(true)
                    }
                }
            }
        }
    }
    
    func login(nickname: String, password: String, completion: @escaping (Bool) -> Void) {
        
        if nickname.isValidEmail && password.isValidPassword {
            Auth.auth().signIn(withEmail: nickname, password: password) { (result, error) in
                if error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
