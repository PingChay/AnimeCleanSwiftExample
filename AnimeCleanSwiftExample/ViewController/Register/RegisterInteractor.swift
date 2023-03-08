//
//  RegisterInteractor.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import Foundation

protocol RegisterDataStore {

}

protocol RegisterBusinessLogic {
    func register(email: String?, password: String?, conformPassword: String?)
}

final class RegisterInteractor: RegisterDataStore, RegisterBusinessLogic {
    private let worker: FirebaseAuthWorker
    private let presenter: RegisterPresentationLogic

    init(worker: FirebaseAuthWorker = FirebaseAuthWorkerImpl(),
         presenter: RegisterPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    func register(email: String?, password: String?, conformPassword: String?) {
        guard let email = email,
                !email.isEmpty,
              let password = password,
                !password.isEmpty,
                let conformPassword = conformPassword,
              !conformPassword.isEmpty else {
            self.presenter.registerFail(type: .someInputIsEmpty)
            return
        }
        
        guard password == conformPassword else {
            self.presenter.registerFail(type: .passwordIsNotMatch)
            return
        }

        worker.registerWith(email: email, password: password) { [weak self] response in
            guard let self = self else { return }

            self.presenter.registerSuccess()
        } onFailure: { [weak self] response in
            guard let self = self else { return }

            self.presenter.registerFail(type: .registerFail(error: response))
        }
    }
}
