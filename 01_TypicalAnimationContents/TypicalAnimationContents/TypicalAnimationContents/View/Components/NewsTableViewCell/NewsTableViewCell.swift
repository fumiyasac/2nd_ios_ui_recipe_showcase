//
//  NewsTableViewCell.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

// MEMO: InterfaceBuilder内で下記のように設定する
// 1. 配置したUIImageViewのcontentModeを.aspectFillとする
// 2. 配置したUIImageViewのclipToBoundsをtrueとする
// 3. 配置したUIImageViewの親のUIViewもclipToBoundsをtrueとする

final class NewsTableViewCell: UITableViewCell {

    // 視差効果のズレを生むための定数（大きいほど視差効果が大きい）
    private let parallaxFactor: CGFloat = 30.0

    // 視差効果の計算用の変数
    private var topInitialConstraint: CGFloat!
    private var bottomInitialConstraint: CGFloat!

    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var newsImageView: UIImageView!

    // UIView内のUIImageViewの上下の制約
    @IBOutlet weak private var topConstraint: NSLayoutConstraint!
    @IBOutlet weak private var bottomConstraint: NSLayoutConstraint!

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupNewsTableViewCell()
    }

    // MARK: - Function

    func setCell(_ news: NewsModel) {
        categoryLabel.text = news.category
        titleLabel.text = news.title
        newsImageView.image = news.image
    }

    // 画像にかけられているAutoLayoutの制約を再計算して制約をかけ直す
    func setImageViewOffset(_ offset: CGFloat) {
        let boundOffset = max(0, min(1, offset))
        let pixelOffset = (1 - boundOffset) * 2 * parallaxFactor
        topConstraint.constant = topInitialConstraint - pixelOffset
        bottomConstraint.constant = bottomInitialConstraint + pixelOffset
    }

    // MARK: - Private Function

    private func setupNewsTableViewCell() {

        // セルの装飾設定をする
        self.accessoryType = .none
        self.selectionStyle = .none

        // 意図的にずらした値を視差効果の計算用の変数にそれぞれセットする
        self.clipsToBounds = true
        bottomConstraint.constant -= 2.0 * parallaxFactor
        topInitialConstraint = topConstraint.constant
        bottomInitialConstraint = bottomConstraint.constant

        // 画像の外枠UIViewに枠線をつける
        if let wrappedView = newsImageView.superview {
            wrappedView.layer.borderWidth = 1.0
            wrappedView.layer.borderColor = UIColor(code: "#dddddd").cgColor
        }
    }
}
