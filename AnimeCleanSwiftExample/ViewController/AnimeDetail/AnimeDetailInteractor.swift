//
//  AnimeDetailInteractor.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import Foundation

protocol AnimeDetailDataStore {
    var anime: Anime? { get set }
    var isFavorite: Bool { get }
}

protocol AnimeDetailBusinessLogic {
    func updateAnimeDetail()
    func toggleFavorite()
}

final class AnimeDetailInteractor: AnimeDetailDataStore, AnimeDetailBusinessLogic {
    private let worker: AnimeFirestoreWorker
    private let presenter: AnimeDetailPresentationLogic

    var anime: Anime?
    private(set) var isFavorite: Bool = false

    init(worker: AnimeFirestoreWorker = AnimeFirestoreWorkerImpl(),
         presenter: AnimeDetailPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    func updateAnimeDetail() {
        presenter.updateAnimeDetail()

        guard let anime = anime else { return }
        worker.getFavoriteAnime(anime: anime) { [weak self] isFavorite in
            guard let self = self else { return }

            self.isFavorite = isFavorite
            self.presenter.updateAnimeDetail()
        } onFailure: { _ in
        }
    }

    func toggleFavorite() {
        guard let anime = anime else { return }
        if isFavorite {
            worker.removeFavoriteAnime(anime: anime) { response in
                self.isFavorite = false
                self.presenter.updateAnimeDetail()
            } onFailure: { error in
            }
        } else {
            worker.addFavoriteAnime(anime: anime) { response in
                self.isFavorite = true
                self.presenter.updateAnimeDetail()
            } onFailure: { error in
            }
        }
    }
}
