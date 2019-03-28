//
//  GiftCommentTableViewCell.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/26.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import Cosmos

final class GiftCommentTableViewCell: UITableViewCell {

    @IBOutlet weak private var commentAuthorLabel: UILabel!
    @IBOutlet weak private var commentRatingView: CosmosView!
    @IBOutlet weak private var commentDetailLabel: UILabel!

    // MARK: -  Override

    override func awakeFromNib() {
        super.awakeFromNib()

        // 特に画面遷移がないのでアクセサリとセレクションを非表示にする
        self.accessoryType = .none
        self.selectionStyle = .none
    }

    // MARK: -  Function

    func setCell(_ giftComment: GiftCommentEntity) {

        // コメント記載者の設定
        let authorKeys = (
            lineSpacing: CGFloat(5),
            font: UIFont(name: "HiraKakuProN-W6", size: 9.0)!,
            foregroundColor: UIColor.lightGray
        )
        let authorAttributes = UILabelDecorator.getLabelAttributesBy(keys: authorKeys)
        commentAuthorLabel.attributedText = NSAttributedString(string: giftComment.author, attributes: authorAttributes)

        // レーティング表示の設定
        commentRatingView.settings.updateOnTouch = false
        commentRatingView.settings.fillMode = .precise
        commentRatingView.rating = giftComment.rating

        // コメント本文の設定
        let commentKeys = (
            lineSpacing: CGFloat(6),
            font: UIFont(name: "HiraKakuProN-W3", size: 11.0)!,
            foregroundColor: UIColor.black
        )
        let commentAttributes = UILabelDecorator.getLabelAttributesBy(keys: commentKeys)
        commentDetailLabel.attributedText = NSAttributedString(string: giftComment.comment, attributes: commentAttributes)
    }
}
