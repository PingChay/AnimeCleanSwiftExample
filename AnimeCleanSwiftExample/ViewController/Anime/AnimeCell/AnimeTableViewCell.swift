//
//  AnimeTableViewCell.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import UIKit
import Kingfisher

class AnimeTableViewCell: UITableViewCell {
    @IBOutlet var animeImage: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var detail: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    var anime: Anime?
    var interactor: AnimeBusinessLogic?

    class func nib() -> UINib {
        return UINib(nibName: "AnimeTableViewCell", bundle: Bundle.main)
    }

    class func height() -> CGFloat {
        return UITableView.automaticDimension
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        favoriteButton.setImage(.init(systemName: "star"), for: .normal)
        favoriteButton.setImage(.init(systemName: "star.fill"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCell(anime: Anime, isFavorite: Bool) {
        animeImage.kf.setImage(with: URL(string: anime.images?["jpg"]?.imageURL ?? ""),
                               options: [
//                                .transition(ImageTransition.fade(0.3)),
                                .forceTransition])
        self.anime = anime
        title.text = anime.title
        detail.text = anime.background
        favoriteButton.isSelected = isFavorite
    }

    @IBAction func favoriteTapped(_ sender: Any) {
        guard let anime = anime else { return }

        if favoriteButton.isSelected {
            interactor?.removeFavorite(anime: anime)
        } else {
            interactor?.addFavorite(anime: anime)
        }
    }
}
