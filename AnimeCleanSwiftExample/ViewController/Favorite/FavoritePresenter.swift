//
//  FavoritePresenter.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import Foundation

enum FavoriteErrorType {
    case requestFail(error: Error)
}

protocol FavoritePresentationLogic {
    func fetchFavoriteSuccess()
    func fetchFavoriteFail(error: FavoriteErrorType)
}

final class FavoritePresenter: FavoritePresentationLogic {
    private let viewController: FavoriteDisplayLogic

    init(viewController: FavoriteDisplayLogic) {
        self.viewController = viewController
    }

    func fetchFavoriteSuccess() {
        viewController.updateFavoriteList()
    }

    func fetchFavoriteFail(error: FavoriteErrorType) {
        viewController.showError(error: error)
    }
}
