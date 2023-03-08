//
//  AnimeDetailRouter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import UIKit
import SafariServices

protocol AnimeDetailDataPassing {
    var dataStore: AnimeDetailDataStore { get }
}

protocol AnimeDetailRoutingLogic {
    func showWebsite(urlString: String?)
    func showDialog(error: AnimeDetailErrorType)
}

class AnimeDetailRouter: AnimeDetailDataPassing, AnimeDetailRoutingLogic {
    private var viewController: UIViewController
    private(set) var dataStore: AnimeDetailDataStore

    init(viewController: UIViewController,
         dataStore: AnimeDetailDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }

    func showWebsite(urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        let sfViewCon = SFSafariViewController(url: url)
        sfViewCon.modalPresentationStyle = .formSheet
        viewController.present(sfViewCon, animated: true)
    }

    func showDialog(error: AnimeDetailErrorType) {
        
    }
}
