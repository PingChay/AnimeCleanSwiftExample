//
//  RegisterPresenter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import Foundation

enum RegisterErrorType {
    case someInputIsEmpty
    case passwordIsNotMatch
    case registerFail(error: Error)
}

protocol RegisterPresentationLogic {
    func registerSuccess()
    func registerFail(type: RegisterErrorType)
}

class RegisterPresenter: RegisterPresentationLogic {
    private let viewController: RegisterDisplayLogic

    init(viewController: RegisterDisplayLogic) {
        self.viewController = viewController
    }

    func registerSuccess() {
        viewController.registerSuccess()
    }

    func registerFail(type: RegisterErrorType) {
        viewController.registerFail(type: type)
    }
}
