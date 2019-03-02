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
        
    }

    // MARK: - Private Function

    // 該当のUILabelに付与する属性を設定する
    private func getLabelAttributesBy(keys: (lineSpacing: CGFloat, font: UIFont, foregroundColor: UIColor)) -> [NSAttributedString.Key : Any] {
        
        // 行間に関する設定をする
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = keys.lineSpacing

        // MEMO: lineBreakModeの指定しないとはみ出た場合の「...」が出なくなる
        paragraphStyle.lineBreakMode = .byTruncatingTail

        // 上記で定義した行間・フォント・色を属性値として設定する
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        attributes[NSAttributedString.Key.font] = keys.font
        attributes[NSAttributedString.Key.foregroundColor] = keys.foregroundColor

        return attributes
    }

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
            superView.layer.masksToBounds = true
            superView.layer.borderColor = UIColor.darkGray.cgColor
            superView.layer.cornerRadius = superView.frame.width * 0.5
        }
    }
}