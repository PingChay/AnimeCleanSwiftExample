//
//  LoginPresenter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

enum LoginErrorType {
    case usernameOrPasswordEmpty
    case usernameInValid
    case loginFail
}

protocol LoginPresentationLogic {
    func showError(error: LoginErrorType)
    func loginFail(error: Error)
}

final class LoginPresenter: LoginPresentationLogic {
    private let viewController: LoginDisplayLogic

    init(viewController: LoginDisplayLogic) {
        self.viewController = viewController
    }

    func showError(error: LoginErrorType) {
        viewController.loginFail(error: error)
    }

    func loginFail(error: Error) {
        viewController.loginFail(error: .loginFail)
    }
}
