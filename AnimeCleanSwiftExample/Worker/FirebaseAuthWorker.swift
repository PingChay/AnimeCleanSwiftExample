//
//  FirebaseAuthWorker.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthWorker {
    func loginWith(email: String, password: String,
                   onSuccess: @escaping(_ response: AuthDataResult) -> Void,
                   onFailure: @escaping(_ response: Error) -> Void)
    func logout()
    func registerWith(email: String, password: String,
                      onSuccess: @escaping(_ response: AuthDataResult) -> Void,
                      onFailure: @escaping(_ response: Error) -> Void)
}

final class FirebaseAuthWorkerImpl: FirebaseAuthWorker {
    private let auth: Auth

    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }

    func loginWith(email: String, password: String,
                   onSuccess: @escaping(_ response: AuthDataResult) -> Void,
                   onFailure: @escaping(_ response: Error) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result: AuthDataResult?, error: Error?) in
            if let error = error {
                onFailure(error)
                return
            }

            guard let result = result else { return }
            onSuccess(result)
        }
    }

    func logout() {
        try? auth.signOut()
    }

    func registerWith(email: String, password: String,
                      onSuccess: @escaping (AuthDataResult) -> Void,
                      onFailure: @escaping (Error) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result: AuthDataResult?, error: Error?) in
            if let error = error {
                onFailure(error)
                return
            }

            guard let result = result else { return }
            onSuccess(result)
        }
    }
}
