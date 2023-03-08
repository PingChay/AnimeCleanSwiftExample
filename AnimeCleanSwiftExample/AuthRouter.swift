//
//  AuthRouter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation
import FirebaseAuth

protocol AuthRoutingLogic {
    func swapRootWithCurrent()
}

class AuthRouter: AuthRoutingLogic {
    private let auth: Auth

    init(auth: Auth = .auth()) {
        self.auth = auth
    }

    func swapRootWithCurrent() {
        if auth.currentUser != nil {
            let mainTabBarController = MainTabBarController.viewController()
            SceneDelegate.main().swapRootViewController(with: mainTabBarController)
        } else {
            let loginViewController = LoginViewController.viewController()
            let navigationViewController = UINavigationController(rootViewController: loginViewController)
            SceneDelegate.main().swapRootViewController(with: navigationViewController)
        }
    }
}
