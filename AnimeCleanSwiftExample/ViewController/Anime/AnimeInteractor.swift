//
//  AnimeInteractor.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

protocol AnimeBusinessLogic {
    func fetchItems()
    func fetchFavoriteItem()
    func updateBookmark(text: String)
    func addFavorite(anime: Anime)
    func removeFavorite(anime: Anime)
    func logout()

    func isFavorite(anime: Anime) -> Bool
}

protocol AnimeDataStore {
    var animeList: [Anime] { get }
    var favoriteItems: [Anime] { get }
}

class AnimeInteractor: AnimeDataStore, AnimeBusinessLogic {
    private let worker: AnimeWorker
    private let authWorker: FirebaseAuthWorker
    private let animeFirestoreWorker: AnimeFirestoreWorker
    private let presenter: AnimePresentationLogic

    private(set) var animeList: [Anime] = []
    private(set) var favoriteItems: [Anime] = []

    init(worker: AnimeWorker = AnimeWorkerImpl(),
         authWorker: FirebaseAuthWorker = FirebaseAuthWorkerImpl(),
         animeFirestoreWorker: AnimeFirestoreWorker = AnimeFirestoreWorkerImpl(),
         presenter: AnimePresentationLogic) {
        self.worker = worker
        self.authWorker = authWorker
        self.animeFirestoreWorker = animeFirestoreWorker
        self.presenter = presenter
    }

    func fetchItems() {
        animeFirestoreWorker.getBookmark { [weak self] bookmark in
            guard let self = self else { return }

            self.getAnimeList(bookmark: bookmark)
        } onFailure: { [weak self] error in
            guard let self = self else { return }

            self.getAnimeList(bookmark: "naruto")
        }
    }

    private func getAnimeList(bookmark: String) {
        worker.getAnime(request: .init(keyword: bookmark, page: 1)) { [weak self] response in
            guard let self = self else { return }

            self.animeList = response.data ?? []
            self.fetchFavoriteItem()
        } onFailure: { [weak self] response in
            guard let self = self else { return }

            self.presenter.presentFail(response: response)
        }
    }

    func fetchFavoriteItem() {
        animeFirestoreWorker.getFavoriteAnime { [weak self] response in
            guard let self = self else { return }

            self.favoriteItems = response
            self.presenter.updateAnimeList()
        } onFailure: { error in
        }
    }

    func updateBookmark(text: String) {
        animeFirestoreWorker.updateBookmark(key: text) { [weak self] bookmark in
            guard let self = self else { return }

            self.fetchItems()
        } onFailure: { [weak self] error in
            guard let self = self else { return }

            self.fetchItems()
        }
    }

    func addFavorite(anime: Anime) {
        animeFirestoreWorker.addFavoriteAnime(anime: anime) { [weak self] response in
            guard let self = self else { return }

            self.favoriteItems = response
            self.presenter.updateAnimeList()
        } onFailure: { error in
        }
    }

    func removeFavorite(anime: Anime) {
        animeFirestoreWorker.removeFavoriteAnime(anime: anime) { [weak self] response in
            guard let self = self else { return }

            self.favoriteItems = response
            self.presenter.updateAnimeList()
        } onFailure: { error in
            
        }
    }

    func logout() {
        authWorker.logout()
    }

    func isFavorite(anime: Anime) -> Bool {
        return (favoriteItems.first { $0.malID == anime.malID } != nil)
    }
}
