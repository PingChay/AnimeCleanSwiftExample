//
//  FavoriteViewController.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import UIKit

protocol FavoriteDisplayLogic {
    func updateFavoriteList()
    func showError(error: FavoriteErrorType)
}

class FavoriteViewController: UIViewController {
    @IBOutlet weak var favoriteTableView: UITableView!

    var interactor: (FavoriteBusinessLogic & FavoriteDataStore)?
    var router: (FavoriteRoutingLogic & FavoriteDataPassing)?

    class func viewController() -> FavoriteViewController {
        let storyboard = UIStoryboard(name: "Favorite", bundle: Bundle.main)

        guard let controller = storyboard.instantiateInitialViewController() as? FavoriteViewController else {
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
        let presenter = FavoritePresenter(viewController: self)
        interactor = FavoriteInteractor(presenter: presenter)
        guard let interactor = interactor else { return }
        router = FavoriteRouter(viewController: self, dataStore: interactor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.fetchFavoriteItem()
    }

    private func bindingTableView() {
        favoriteTableView.register(FavoriteTableViewCell.nib(), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.rowHeight = FavoriteTableViewCell.height()
        favoriteTableView.separatorStyle = .none
    }
}

extension FavoriteViewController: FavoriteDisplayLogic {
    func updateFavoriteList() {
        favoriteTableView.reloadData()
    }

    func showError(error: FavoriteErrorType) {
        router?.showDialog(error: error)
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath)
        guard let cell = cell as? FavoriteTableViewCell,
              let animeModel = interactor?.favoriteItems[indexPath.row] else {
            return cell
        }

        cell.selectionStyle = .none
        cell.updateCell(anime: animeModel)
        cell.layoutIfNeeded()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let animeModel = interactor?.favoriteItems[indexPath.row] else {
            return
        }

        router?.openDetail(anime: animeModel)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavoriteTableViewCell.height()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.favoriteItems.count ?? 0
    }
}
