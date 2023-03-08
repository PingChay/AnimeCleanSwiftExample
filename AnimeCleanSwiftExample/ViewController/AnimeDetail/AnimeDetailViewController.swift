//
//  AnimeDetailViewController.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import UIKit
import Kingfisher

protocol AnimeDetailDisplayLogic {
    func updateAnimeDetail()
    func showError(error: AnimeDetailErrorType)
}

class AnimeDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    var interactor: (AnimeDetailBusinessLogic & AnimeDetailDataStore)?
    var router: (AnimeDetailRoutingLogic & AnimeDetailDataPassing)?

    class func viewController() -> AnimeDetailViewController {
        let storyboard = UIStoryboard(name: "AnimeDetail", bundle: Bundle.main)

        guard let controller = storyboard.instantiateInitialViewController() as? AnimeDetailViewController else {
            fatalError("missing load controller from storyboard")
        }

        return controller
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let presenter = AnimeDetailPresenter(viewController: self)
        interactor = AnimeDetailInteractor(presenter: presenter)
        guard let interactor = interactor else { return }
        router = AnimeDetailRouter(viewController: self, dataStore: interactor)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteButton.setImage(.init(systemName: "star"), for: .normal)
        favoriteButton.setTitle("Favorite", for: .normal)
        favoriteButton.setImage(.init(systemName: "star.fill"), for: .selected)
        favoriteButton.setTitle("Unfavorite", for: .selected)

        interactor?.updateAnimeDetail()
    }

    @IBAction func openWebsiteTapped(_ sender: Any) {
        router?.showWebsite(urlString: interactor?.anime?.url)
    }

    @IBAction func favoriteTapped(_ sender: Any) {
        interactor?.toggleFavorite()
    }
}

extension AnimeDetailViewController: AnimeDetailDisplayLogic {
    func updateAnimeDetail() {
        guard let anime = interactor?.anime else { return }

        animeImageView.kf.setImage(with: URL(string: anime.images?["jpg"]?.imageURL ?? ""),
                                   options: [
                                    .transition(ImageTransition.fade(0.3)),
                                    .forceTransition])
        titleLabel.text = anime.title
        detailLabel.text = anime.background

        favoriteButton.isSelected = interactor?.isFavorite ?? false
    }

    func showError(error: AnimeDetailErrorType) {
        router?.showDialog(error: error)
    }
}
