//
//  AppDelegate.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 2/3/2566 BE.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        firebaseSetup()
        firebaseAuthSetup()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate {
    private func firebaseSetup() {
        FirebaseApp.configure()
    }

    private func firebaseAuthSetup() {
        Auth.auth().addStateDidChangeListener { auth, user in
            let authRouter: AuthRoutingLogic = AuthRouter()
            authRouter.swapRootWithCurrent()
            aaa
        }
    }
}

