//
//  AnimePresenter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation

protocol AnimePresentationLogic {
    func updateAnimeList()
    func presentFail(response: ResponseFail)
}

class AnimePresenter: AnimePresentationLogic {
    private var viewController: AnimeDisplayLogic

    init(viewController: AnimeDisplayLogic) {
        self.viewController = viewController
    }

    func updateAnimeList() {
        viewController.updateAnimeList()
    }

    func presentFail(response: ResponseFail) {
        viewController.errorOnFetchAnimeList(response: response)
    }
}
