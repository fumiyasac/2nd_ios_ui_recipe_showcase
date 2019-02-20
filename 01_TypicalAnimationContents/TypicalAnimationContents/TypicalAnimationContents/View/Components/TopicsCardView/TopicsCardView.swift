//
//  TopicsCardView.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

// MEMO: このViewはSafeAreaをキャンセルした状態にする
// (Viewサイズの変更を伴うトランジションと合わせる場合)
final class TopicsCardView: CustomViewBase {

    // View同士の間隔
    static let cardMargin: CGFloat = 20.0

    // Viewのサイズ
    static let viewSize: CGSize = CGSize(width: UIScreen.main.bounds.width - cardMargin * 2, height: UIScreen.main.bounds.height * 0.42)

    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var publishDateLabel: UILabel!
    @IBOutlet weak private var catchCopyLabel: UILabel!
    @IBOutlet weak private var topicImageView: UIImageView!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupTopicsCardView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupTopicsCardView()
    }

    // MARK: - Function

    func setView(_ topic: TopicsModel) {
        titleLabel.text = topic.title
        categoryLabel.text = topic.category
        publishDateLabel.text = topic.publishDate
        catchCopyLabel.text = topic.catchCopy
        topicImageView.image = topic.image
    }

    // MARK: - Private Function

    private func setupTopicsCardView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
    }
}
