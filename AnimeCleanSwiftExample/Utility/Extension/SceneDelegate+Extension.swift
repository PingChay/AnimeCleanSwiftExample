//
//  File.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation
import UIKit

extension SceneDelegate {
    class func main() -> SceneDelegate {
        return SceneDelegate.shared!
    }

    func swapRootViewController(with loadView: UIViewController) {
        if self.window?.rootViewController != nil {
            self.window!.rootViewController = loadView
            loadView.view.layoutIfNeeded()

            UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            }, completion: { completed in
            })
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = loadView
            self.window?.makeKeyAndVisible()
        }
    }
}
