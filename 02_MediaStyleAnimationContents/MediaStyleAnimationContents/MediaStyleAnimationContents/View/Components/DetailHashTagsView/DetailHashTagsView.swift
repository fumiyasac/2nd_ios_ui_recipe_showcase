//
//  DetailHashTagsView.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/09.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift
import ActiveLabel

final class DetailHashTagsView: CustomViewBase {

    // ハッシュタグとして表示する文字列を定義する(今回はサンプル)
    private let sampleTagsList = [
        "#一度は見たい風景", "#絶景特集", "#旅行", "#観光地",
        "#風景", "#写真", "#思い出フォト", "#サンプル", "#素材"
    ]

    @IBOutlet weak private var hashTagsImageView: UIImageView!
    @IBOutlet weak private var hashTagsLabel: ActiveLabel!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupDetailHashTagsView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupDetailHashTagsView()
    }

    // MARK: - Private Function

    private func setupDetailHashTagsView() {

        // タグ表示アイコンの設定
        let iconColor = UIColor(code: "#cf504c")
        let iconSize  = CGSize(width: 16.0, height: 16.0)
        hashTagsImageView.image = UIImage.fontAwesomeIcon(name: .tags, style: .solid, textColor: iconColor, size: iconSize)

        // ハッシュタグの属性と表示の設定
        let hashTagsAttributes = UILabelDecorator.getHashTagsAttributesBy(minimumLineHeight: CGFloat(20))
        let hashtagsString = sampleTagsList.joined(separator: " ")
        hashTagsLabel.attributedText = NSAttributedString(string: hashtagsString, attributes: hashTagsAttributes)
        hashTagsLabel.enabledTypes = [.hashtag]
        hashTagsLabel.handleHashtagTap { hashtag in
            print("押下されたハッシュタグ：\(hashtag)")
        }
    }
}
