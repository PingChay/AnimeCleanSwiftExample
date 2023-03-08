//
//  FavoriteInteractor.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import Foundation

protocol FavoriteBusinessLogic {
    func fetchFavoriteItem()
}

protocol FavoriteDataStore {
    var favoriteItems: [Anime] { get }
}

class FavoriteInteractor: FavoriteDataStore, FavoriteBusinessLogic {
    private let worker: AnimeFirestoreWorker
    private let presenter: FavoritePresentationLogic

    private(set) var favoriteItems: [Anime] = []

    init(worker: AnimeFirestoreWorker = AnimeFirestoreWorkerImpl(),
         presenter: FavoritePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    func fetchFavoriteItem() {
        worker.getFavoriteAnime { [weak self] response in
            guard let self = self else { return }

            self.favoriteItems = response
            self.presenter.fetchFavoriteSuccess()
        } onFailure: { [weak self] error in
            guard let self = self else { return }

            self.presenter.fetchFavoriteFail(error: .requestFail(error: error))
        }
    }
}
