//
//  PhotoGalleryCollectionViewCell.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

// MEMO: InterfaceBuilder内で下記のように設定する
// 1. 配置したUIImageViewのcontentModeを.aspectFillとする
// 2. 配置したUIImageViewのclipToBoundsをtrueとする

final class PhotoGalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var summaryLabel: UILabel!
    @IBOutlet weak private var photoGalleryImageView: UIImageView!

    // MARK: - Function

    func setCell(_ photo: PhotoGalleryModel) {

        // 画像データを表示する
        // MEMO: UIImageViewに取得した画像を反映させる際に0.24秒遅延させる
        // → この処理を行わないとUICollectionViewCellの画像が調整されないまま表示されてしまうためレイアウトが崩れる
        photoGalleryImageView.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
            self.photoGalleryImageView.image = photo.image
            UIView.animate(withDuration: 0.24, animations: {
                self.photoGalleryImageView.alpha = 1
            })
        }

        // タイトル表示用ラベルの装飾を適用して表示する
        let titleAttributes = getAttributesForLabel(
            lineSpacing: 5,
            font: UIFont(name: "HiraKakuProN-W6", size: 12.0)!,
            foregroundColor: UIColor(code: "#333333")
        )
        titleLabel.attributedText = NSAttributedString(string: photo.title, attributes: titleAttributes)

        // サマリー表示用ラベルの装飾を適用して表示する
        let summaryAttributes = getAttributesForLabel(
            lineSpacing: 6,
            font: UIFont(name: "HiraKakuProN-W3", size: 11.0)!,
            foregroundColor: UIColor(code: "#777777")
        )
        summaryLabel.attributedText = NSAttributedString(string: photo.summary, attributes: summaryAttributes)

        // セルの装飾を適用する
        setCellDecoration()
    }

    // MARK: - Private Function

    // ラベルの装飾用(行間やフォント・配色)attributesを取得する
    private func getAttributesForLabel(lineSpacing: CGFloat, font: UIFont, foregroundColor: UIColor) -> [NSAttributedString.Key : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        // MEMO: これを指定しないとはみ出た場合の「...」が出なくなる
        paragraphStyle.lineBreakMode = .byTruncatingTail

        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = foregroundColor
        return attributes
    }
    
    // セルの装飾(罫線やシャドウ等のlayerプロパティに対して適用するもの)を適用する
    private func setCellDecoration() {

        // UICollectionViewのcontentViewプロパティには罫線と角丸に関する設定を行う
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor(code: "#dddddd").cgColor

        // UICollectionViewのおおもとの部分にはドロップシャドウに関する設定を行う
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(code: "#aaaaaa").cgColor
        self.layer.shadowOffset = CGSize(width: 0.75, height: 1.75)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 0.33

        // ドロップシャドウの形状をcontentViewに付与した角丸を考慮するようにする
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
