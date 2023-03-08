//
//  RegisterRouter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import UIKit

protocol RegisterDataPassing {
    var dataStore: RegisterDataStore { get }
}

protocol RegisterRoutingLogic {
    func openLogin()
    func showDialog(error: RegisterErrorType)
}

final class RegisterRouter: RegisterDataPassing, RegisterRoutingLogic {
    private var viewController: UIViewController
    var dataStore: RegisterDataStore

    init(viewController: UIViewController,
         dataStore: RegisterDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }

    func openLogin() {
        viewController.navigationController?.popToRootViewController(animated: true)
    }

    func showDialog(error: RegisterErrorType) {
        let title: String
        let message: String
        switch error {
            case .someInputIsEmpty:
                title = "Error"
                message = "กรุณากรอกข้อมูลให้ครบถ้วน"
            case .passwordIsNotMatch:
                title = "Error"
                message = "กรุณากรอก password ให้เหมือนกัน"
            case let .registerFail(error: error):
                title = "สมัครสมาชิกไม่สำเร็จ"
                message = error.localizedDescription
        }

        let alert: UIAlertController = .init(title: title,
                                             message: message,
                                             preferredStyle: .alert)

        alert.addAction(.init(title: "Close",
                              style: .default, handler: { _ in }))

        viewController.present(alert, animated: true)
    }
}
