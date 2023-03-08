//
//  AnimeViewController.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 2/3/2566 BE.
//

import UIKit

protocol AnimeDisplayLogic {
    func updateAnimeList()
    func errorOnFetchAnimeList(response: ResponseFail)
}

class AnimeViewController: UIViewController {
    @IBOutlet var animeTableView: UITableView!

    var interactor: (AnimeBusinessLogic & AnimeDataStore)?
    var router: (AnimeRoutingLogic & AnimeDataPassing)?

    class func viewController() -> AnimeViewController {
        let storyboard = UIStoryboard(name: "Anime", bundle: Bundle.main)

        guard let controller = storyboard.instantiateInitialViewController() as? AnimeViewController else {
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
        let presenter = AnimePresenter(viewController: self)
        interactor = AnimeInteractor(presenter: presenter)
        guard let interactor = interactor else { return }
        router = AnimeRouter(viewController: self, dataStore: interactor)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindingTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        interactor?.fetchItems()
    }

    private func bindingTableView() {
        animeTableView.register(AnimeTableViewCell.nib(), forCellReuseIdentifier: AnimeTableViewCell.identifier)
        animeTableView.delegate = self
        animeTableView.dataSource = self
        animeTableView.rowHeight = AnimeTableViewCell.height()
    }

    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        interactor?.logout()
    }

    @IBAction func bookmarkTapped(_ sender: Any) {
        router?.showBookmarkInput(onSubmit: { [weak self] inputText in
            guard let self = self else { return }

            self.interactor?.updateBookmark(text: inputText)
        })
    }
}

extension AnimeViewController: AnimeDisplayLogic {
    func errorOnFetchAnimeList(response: ResponseFail) {
        
    }

    func updateAnimeList() {
        animeTableView.reloadData()
    }
}

extension AnimeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimeTableViewCell.identifier, for: indexPath)
        guard let cell = cell as? AnimeTableViewCell,
              let animeModel = interactor?.animeList[indexPath.row] else {
            return cell
        }
        cell.interactor = interactor
        let isFavorite = interactor?.isFavorite(anime: animeModel) ?? false
        cell.updateCell(anime: animeModel, isFavorite: isFavorite)
        cell.layoutIfNeeded()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let animeModel = interactor?.animeList[indexPath.row] else {
            return
        }

        router?.openDetail(anime: animeModel)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AnimeTableViewCell.height()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.animeList.count ?? 0
    }
}
