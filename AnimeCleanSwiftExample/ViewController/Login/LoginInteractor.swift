//
//  LoginInteractor.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation
import FirebaseAuth

protocol LoginBusinessLogic {
    func login(email: String?, password: String?)
}

protocol LoginDataStore {

}

final class LoginInteractor: LoginDataStore, LoginBusinessLogic {
    private let worker: FirebaseAuthWorker
    private let presenter: LoginPresentationLogic

    init(worker: FirebaseAuthWorker = FirebaseAuthWorkerImpl(),
         presenter: LoginPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    func login(email: String?, password: String?) {
        guard let email = email,
              let password = password else {
            presenter.showError(error: .usernameOrPasswordEmpty)
            return
        }

        guard checkLoginInput(email: email, password: password) else { return }

        worker.loginWith(email: email, password: password) { _ in
        } onFailure: { [weak self] error in
            guard let self = self else { return }
            self.presenter.loginFail(error: error)
        }
    }

    private func checkLoginInput(email: String, password: String) -> Bool {
        guard !email.isEmpty,
              !password.isEmpty else {
            presenter.showError(error: .usernameOrPasswordEmpty)
            return false
        }

        // check email format
        // ...

        return true
    }
}
