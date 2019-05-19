//
//  DetailRecommendCollectionViewCell.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/09.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FontAwesome_swift
import AlamofireImage

final class DetailRecommendCollectionViewCell: UICollectionViewCell {

    // MEMO: サムネイル画像を表示するUIImageViewにおけるInterfaceBuilder上の設定
    // 設定1. Content Modeを「AspectFill」とする
    // 設定2. Clip To Boundsの項目にチェックを入れる

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var thumbnailImageView: UIImageView!
    @IBOutlet weak private var starImageView: UIImageView!
    @IBOutlet weak private var rateLabel: UILabel!

    // 高さが可変となるUILabelの高さ制約値
    @IBOutlet weak private var titleHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupStarImageView()
    }

    // MARK: - Static Function

    static func getCellSize() -> CGSize {

        // MEMO: 縦方向のセルの余白数とマージン値を設定する
        let numberOfMargin: CGFloat = 3
        let cellMargin: CGFloat = 10.0

        let cellWidth: CGFloat = (UIScreen.main.bounds.width - cellMargin * numberOfMargin) / 2
        let cellHeight: CGFloat = 240.0
        return CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Function

    func setCell(_ detailRecommend: DetailRecommendEntity) {

        // 画像データを表示する
        if let imageURL = detailRecommend.imageUrl {
            thumbnailImageView.af_setImage(withURL: imageURL)
        }

        // タイトル表示用ラベルの装飾を適用して表示する
        let titleKeys = (
            lineSpacing: CGFloat(5),
            font: UIFont(name: "HiraKakuProN-W6", size: 12.0)!,
            foregroundColor: UIColor(code: "#333333")
        )
        let titleAttributes = UILabelDecorator.getLabelAttributesBy(keys: titleKeys)
        titleLabel.attributedText = NSAttributedString(string: detailRecommend.title, attributes: titleAttributes)

        // 評価レーティング表示用ラベルを表示する
        rateLabel.text = detailRecommend.rates

        // このUICollectionViewに装飾を適用する
        UICollectionViewDecorator.decorateCollectionViewCell(self, withinImageView: thumbnailImageView)
    }

    // MARK: - Private Function

    // 画像アイコン部分の初期設定を行う
    private func setupStarImageView() {

        // FontAwesomeのアイコンに関する設定
        let iconColor: UIColor = UIColor(code: "#ffca00")
        let iconSize: CGSize = CGSize(width: 16.0, height: 16.0)

        starImageView.image = UIImage.fontAwesomeIcon(name: .star, style: .solid, textColor: iconColor, size: iconSize)
    }
}
