//
//  MainTabBarController.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import UIKit

class MainTabBarController: UITabBarController {
    class func viewController() -> MainTabBarController {
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: Bundle.main)

        guard let controller = storyboard.instantiateInitialViewController() as? MainTabBarController else {
            fatalError("missing load controller from storyboard")
        }

        return controller
    }
}
