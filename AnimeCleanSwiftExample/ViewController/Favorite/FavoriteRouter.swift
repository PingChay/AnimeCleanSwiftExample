//
//  FavoriteRouter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import UIKit

protocol FavoriteDataPassing {
    var dataStore: FavoriteDataStore { get }
}

protocol FavoriteRoutingLogic {
    func openDetail(anime: Anime)
    func showDialog(error: FavoriteErrorType)
}

class FavoriteRouter: FavoriteDataPassing, FavoriteRoutingLogic {
    private var viewController: UIViewController
    private(set) var dataStore: FavoriteDataStore

    init(viewController: UIViewController,
         dataStore: FavoriteDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }

    func openDetail(anime: Anime) {
        let animeDetail = AnimeDetailViewController.viewController()
        viewController.navigationController?.pushViewController(animeDetail, animated: true)
        animeDetail.interactor?.anime = anime
    }

    func showDialog(error: FavoriteErrorType) {
        let title: String
        let message: String
        switch error {
            case let .requestFail(error: error):
                title = "Error"
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
