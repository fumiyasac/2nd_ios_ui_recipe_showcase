//
//  ProfileTableViewCell.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/02.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FontAwesome_swift

final class ProfileTableViewCell: UITableViewCell {

    private let iconSize: CGSize = CGSize(width: 48.0, height: 48.0)

    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupProfileTableViewCell()
    }

    // MARK: - Function

    func setCell(_ profileList: ProfileLists) {
        titleLabel.text = profileList.getTitle()
        titleLabel.textColor = profileList.getColor()
        let descriptionKeys = (
            lineSpacing: CGFloat(5),
            font: UIFont(name: "HiraKakuProN-W3", size: 10.0)!,
            foregroundColor: UIColor(code: "#777777")
        )
        let descriptionAttributes = getLabelAttributesBy(keys: descriptionKeys)
        descriptionLabel.attributedText = NSAttributedString(string: profileList.getDescription(), attributes: descriptionAttributes)
        iconImageView.image = UIImage.fontAwesomeIcon(name: .file, style: .solid, textColor: UIColor(code: "#dddddd"), size: iconSize)
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

    private func setupProfileTableViewCell() {
        self.accessoryType = .none
        self.selectionStyle = .none
    }
}
