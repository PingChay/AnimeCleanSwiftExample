//
//  AnimeDetailPresenter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import Foundation

enum AnimeDetailErrorType {
    case requestFail(error: Error)
}

protocol AnimeDetailPresentationLogic {
    func updateAnimeDetail()
}

final class AnimeDetailPresenter: AnimeDetailPresentationLogic {
    private let viewController: AnimeDetailDisplayLogic

    init(viewController: AnimeDetailDisplayLogic) {
        self.viewController = viewController
    }

    func updateAnimeDetail() {
        viewController.updateAnimeDetail()
    }
}
