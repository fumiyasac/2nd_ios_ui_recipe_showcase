//
//  DetailMainArticleElementView.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/08.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

final class DetailMainArticleElementView: CustomViewBase {

    @IBOutlet weak private var desctiptionImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var summaryLabel: UILabel!
    @IBOutlet weak private var totalViewsImageView: UIImageView!
    @IBOutlet weak private var totalViewsLabel: UILabel!

    @IBOutlet weak private var publishDateImageView: UIImageView!
    @IBOutlet weak private var publishDateLabel: UILabel!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupDetailMainArticleElementView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupDetailMainArticleElementView()
    }

    // MARK: - Function

    func setEntity(_ mainArticle: MainArticleEntity) {

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
        totalViewsLabel.text = mainArticle.totalViews
        publishDateLabel.text = mainArticle.publishDate
    }

    // MARK: - Private Function

    private func setupDetailMainArticleElementView() {

        // FontAwesomeのアイコンに関する設定
        let iconColor: UIColor = UIColor(code: "#cf504c")
        let iconSize: CGSize = CGSize(width: 16.0, height: 16.0)

        desctiptionImageView.image = UIImage.fontAwesomeIcon(name: .images, style: .solid, textColor: iconColor, size: iconSize)
        publishDateImageView.image = UIImage.fontAwesomeIcon(name: .clock, style: .regular, textColor: iconColor, size: iconSize)
        totalViewsImageView.image = UIImage.fontAwesomeIcon(name: .eye, style: .regular, textColor: iconColor, size: iconSize)
    }
}
