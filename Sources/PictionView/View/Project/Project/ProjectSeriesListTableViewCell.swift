//
//  ProjectSeriesListTableViewCell.swift
//  PictionView
//
//  Created by jhseo on 03/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

final class ProjectSeriesListTableViewCell: ReuseTableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var backgroundThumbnailImageView: UIImageView!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!

    typealias Model = SeriesModel

    func configure(with model: Model) {
        let (seriesName, postCount) = (model.name, model.postCount)

        //        if let url = URL(string: postList.first?.cover ?? "") {
        //            thumbnailImageView.sd_setImageWithFade(with: url, placeholderImage: #imageLiteral(resourceName: "img-dummy-square-500-x-500"), completed: nil)
        //        } else {
        //            thumbnailImageView.image = #imageLiteral(resourceName: "img-dummy-square-500-x-500")
        //        }
        //
        //        if let url = URL(string: postList[safe: 1]?.cover ?? "") {
        //            thumbnailImageView.sd_setImageWithFade(with: url, placeholderImage: #imageLiteral(resourceName: "img-dummy-square-500-x-500"), completed: nil)
        //        } else {
        //            thumbnailImageView.image = UIImage()
        //        }
        seriesLabel.text = seriesName
        postCountLabel.text = "\(String(postCount ?? 0)) 포스트"
    }
}
