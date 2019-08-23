//
//  ExplorerNoticeTableViewCell.swift
//  PictionView
//
//  Created by jhseo on 12/07/2019.
//  Copyright © 2019 Piction Network. All rights reserved.
//

import UIKit
import PictionSDK

final class ExplorerNoticeTableViewCell: ReuseTableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!

    typealias Model = BannerModel

    func configure(with model: Model) {
        let (thumbnail) = (model.image)

        let thumbnailWithIC = "\(thumbnail ?? "")?w=720&h=360&quality=70&output=webp"
        if let url = URL(string: thumbnailWithIC) {
            thumbnailImageView.sd_setImageWithFade(with: url, placeholderImage: #imageLiteral(resourceName: "img-dummy-projectcover-1440-x-450"), completed: nil)
        } else {
            thumbnailImageView.image = #imageLiteral(resourceName: "img-dummy-projectcover-1440-x-450")
        }
    }
}
