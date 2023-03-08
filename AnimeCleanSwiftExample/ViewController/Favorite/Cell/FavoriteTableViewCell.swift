//
//  FavoriteTableViewCell.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 7/3/2566 BE.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    class func nib() -> UINib {
        return UINib(nibName: "FavoriteTableViewCell", bundle: Bundle.main)
    }

    class func height() -> CGFloat {
        return UITableView.automaticDimension
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCell(anime: Anime) {
        animeImageView.kf.setImage(with: URL(string: anime.images?["jpg"]?.imageURL ?? ""),
                               options: [
//                                .transition(ImageTransition.fade(0.3)),
                                .forceTransition])
        titleLabel.text = anime.title
        detailLabel.text = anime.background
    }
}
