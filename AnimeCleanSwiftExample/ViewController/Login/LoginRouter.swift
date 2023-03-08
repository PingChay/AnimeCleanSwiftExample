//
//  LoginRouter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import UIKit

protocol LoginDataPassing {
    var dataStore: LoginDataStore { get }
}

protocol LoginRoutingLogic {
    func openRegister()
    func showDialog(error: LoginErrorType)
}

final class LoginRouter: LoginDataPassing, LoginRoutingLogic {
    private var viewController: UIViewController
    var dataStore: LoginDataStore

    init(viewController: UIViewController,
         dataStore: LoginDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }

    func openRegister() {
        let registerViewController = RegisterViewController.viewController()
        viewController.navigationController?.pushViewController(registerViewController, animated: true)
    }

    func showDialog(error: LoginErrorType) {
        let title: String
        let message: String
        switch error {
            case .usernameOrPasswordEmpty:
                title = "Error"
                message = "กรุณากรอก email และ password"
            case .usernameInValid:
                title = "Error"
                message = "กรอก email ไม่ถูกต้อง"
            case .loginFail:
                title = "Error"
                message = "เข้าระบบไม่สำเร็จ"
        }

        let alert: UIAlertController = .init(title: title,
                                             message: message,
                                             preferredStyle: .alert)

        alert.addAction(.init(title: "Close",
                              style: .default, handler: { _ in }))

        viewController.present(alert, animated: true)
    }
}
