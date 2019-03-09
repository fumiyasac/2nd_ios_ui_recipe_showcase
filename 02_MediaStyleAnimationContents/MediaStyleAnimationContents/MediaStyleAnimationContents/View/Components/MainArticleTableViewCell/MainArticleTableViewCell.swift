//
//  MainArticleTableViewCell.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FontAwesome_swift
import AlamofireImage

final class MainArticleTableViewCell: UITableViewCell {

    static let cellHeight: CGFloat = 80.0

    private let iconDefaultColor: UIColor = UIColor(code: "#bbbbbb")
    private let iconSelectedColor: UIColor = UIColor(code: "#d7847e")
    private let iconSize: CGSize = CGSize(width: 16.0, height: 16.0)

    @IBOutlet weak private var thumbnailImageView: UIImageView!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var summaryLabel: UILabel!
    @IBOutlet weak private var publishDateImageView: UIImageView!
    @IBOutlet weak private var publishDateLabel: UILabel!
    @IBOutlet weak private var totalViewsImageView: UIImageView!
    @IBOutlet weak private var totalViewsLabel: UILabel!
    @IBOutlet weak private var archiveImageView: UIImageView!

    // MARK: - Initializer
 
    override func awakeFromNib() {
        super.awakeFromNib()

        setupMainArticleTableViewCell()
    }

    // MARK: - Function

    func setCell(_ mainArticle: MainArticleEntity) {

        // 画像を表示する
        if let thumbnailUrl = mainArticle.thumbnailUrl {

            // 表示する画像に角丸をつけるためのフィルタ
            let thumbnailFilter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: thumbnailImageView.frame.size,
                radius: 6.0
            )

            // 表示時のプレースホルダー画像・フィルタ・トランジションも引数に設定する
            thumbnailImageView.af_setImage(
                withURL: thumbnailUrl,
                placeholderImage: UIImage(named: "placeholder"),
                filter: thumbnailFilter,
                imageTransition: .crossDissolve(0.2)
            )
        }

        // カテゴリ表示用ラベルをEnumでの定義をもとに表示する
        categoryLabel.text = ArticleCategoryLists(rawValue: mainArticle.category)?.getDisplayName()

        // タイトル表示用ラベルの装飾を適用して表示する
        let titleKeys = (
            lineSpacing: CGFloat(6),
            font: UIFont(name: "HiraKakuProN-W6", size: 11.0)!,
            foregroundColor: UIColor(code: "#333333")
        )
        let titleAttributes = UILabelDecorator.getLabelAttributesBy(keys: titleKeys)
        titleLabel.attributedText = NSAttributedString(string: mainArticle.title, attributes: titleAttributes)

        // サマリー表示用ラベルの装飾を適用して表示する
        let summaryKeys = (
            lineSpacing: CGFloat(4),
            font: UIFont(name: "HiraKakuProN-W3", size: 10.0)!,
            foregroundColor: UIColor(code: "#777777")
        )
        let summaryAttributes = UILabelDecorator.getLabelAttributesBy(keys: summaryKeys)
        summaryLabel.attributedText = NSAttributedString(string: mainArticle.summary, attributes: summaryAttributes)

        // その他表示要素を表示する
        publishDateLabel.text = mainArticle.publishDate
        totalViewsLabel.text = mainArticle.totalViews
    }

    // MARK: - Private Function

    private func setupMainArticleTableViewCell() {

        // UITableViewCellに関するそれ自体に関する設定
        self.accessoryType = .none
        self.selectionStyle = .none

        // FontAwesomeのアイコンに関する設定
        publishDateImageView.image = UIImage.fontAwesomeIcon(name: .clock, style: .regular, textColor: iconDefaultColor, size: iconSize)
        totalViewsImageView.image = UIImage.fontAwesomeIcon(name: .eye, style: .regular, textColor: iconDefaultColor, size: iconSize)
        archiveImageView.image = UIImage.fontAwesomeIcon(name: .clipboardList, style: .solid, textColor: iconDefaultColor, size: iconSize)

        // カテゴリ用ラベルの装飾に関する設定
        categoryLabel.layer.cornerRadius = 5.0

        // アーカイブ状況表示のViewに関する設定
        if let superView = archiveImageView.superview {
            superView.backgroundColor = UIColor(code: "#eeeeee")
            superView.layer.masksToBounds = true
            superView.layer.borderColor = UIColor.darkGray.cgColor
            superView.layer.cornerRadius = superView.frame.width * 0.5
        }
    }
}
