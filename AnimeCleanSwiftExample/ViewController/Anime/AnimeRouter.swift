//
//  AnimeRouter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import UIKit

protocol AnimeDataPassing {
    var dataStore: AnimeDataStore { get }
}

protocol AnimeRoutingLogic {
    func showBookmarkInput(onSubmit: @escaping(_ inputText: String) -> Void)
    func openDetail(anime: Anime)
    func showDialog(response: ResponseFail)
}

class AnimeRouter: AnimeDataPassing, AnimeRoutingLogic {
    private var viewController: AnimeViewController
    private(set) var dataStore: AnimeDataStore

    init(viewController: AnimeViewController,
         dataStore: AnimeDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }

    func showBookmarkInput(onSubmit: @escaping (String) -> Void) {
        let alert: UIAlertController = .init(title: "Bookmark",
                                             message: "input",
                                             preferredStyle: .alert)

        alert.addTextField()

        alert.addAction(.init(title: "Close",
                              style: .cancel, handler: { _ in }))

        alert.addAction(.init(title: "Submit",
                              style: .default, handler: { _ in
            guard let text = (alert.textFields?.first as? UITextField)?.text else {
                return
            }
            onSubmit(text)
        }))

        viewController.present(alert, animated: true)
    }

    func openDetail(anime: Anime) {
        let animeDetail = AnimeDetailViewController.viewController()
        viewController.navigationController?.pushViewController(animeDetail, animated: true)
        animeDetail.interactor?.anime = anime
    }

    func showDialog(response: ResponseFail) {
        let alert: UIAlertController = .init(title: response.error,
                                             message: response.message,
                                             preferredStyle: .alert)

        alert.addAction(.init(title: "Close",
                              style: .default, handler: { _ in }))

        viewController.present(alert, animated: true)
    }
}
