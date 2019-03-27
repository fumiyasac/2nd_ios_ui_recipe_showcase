//
//  GalleryCollectionViewCell.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var thumbnailImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var summaryLabel: UILabel!

    // MARK: - Function

    func setCell(_ gallery: GalleryEntity) {

        // ギャラリー用画像の設定
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.image = UIImage(named: gallery.imageName)

        // タイトルの設定
        let titleKeys = (
            lineSpacing: CGFloat(6),
            font: UIFont(name: "HiraKakuProN-W6", size: 18.0)!,
            foregroundColor: UIColor.white
        )
        let titleAttributes = UILabelDecorator.getLabelAttributesBy(keys: titleKeys)
        titleLabel.attributedText = NSAttributedString(string: gallery.title, attributes: titleAttributes)

        // サマリーの設定
        let summaryKeys = (
            lineSpacing: CGFloat(5),
            font: UIFont(name: "HiraKakuProN-W3", size: 14.0)!,
            foregroundColor: UIColor.white
        )
        let summaryAttributes = UILabelDecorator.getLabelAttributesBy(keys: summaryKeys)
        summaryLabel.attributedText = NSAttributedString(string: gallery.summary, attributes: summaryAttributes)
    }
}
