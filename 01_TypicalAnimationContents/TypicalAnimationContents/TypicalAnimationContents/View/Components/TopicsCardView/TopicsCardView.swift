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

// MARK: - Protocol

protocol TopicsCardViewDelegate: class {
    func closeTopicsCard()
}

final class TopicsCardView: CustomViewBase {

    weak var delegate: TopicsCardViewDelegate?

    // View同士の間隔
    static let cardMargin: CGFloat = 20.0

    // Viewのサイズ
    static let viewSize: CGSize = CGSize(width: UIScreen.main.bounds.width - cardMargin * 2, height: 400.0)

    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var topicImageView: UIImageView!
    @IBOutlet weak private var publishDateLabel: UILabel!
    @IBOutlet weak private var catchCopyLabel: UILabel!

    @IBOutlet weak private var closeButton: UIButton!
    @IBOutlet weak private var closeButtonImageView: UIImageView!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupTopicsCardView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupTopicsCardView()
    }

    // MARK: - Struct

    struct LayoutState {

        public let cornerRadius: CGFloat
        public let shouldCloseButtonHide: Bool

        private init(cornerRadius: CGFloat, shouldCloseButtonHide: Bool) {
            self.cornerRadius = cornerRadius
            self.shouldCloseButtonHide = shouldCloseButtonHide
        }

        // 定義した状態に応じたこのViewの角丸と閉じるボタン設定を作成する
        public static let collapsed = LayoutState(cornerRadius: 13.0, shouldCloseButtonHide: true)
        public static let expanded  = LayoutState(cornerRadius: 0.0, shouldCloseButtonHide: false)
    }

    // MARK: - Function

    func setCell() {
        
    }

    // 引数で渡されたレイアウトに関する定義を適用する
    func applyLayoutSettings(layoutState: TopicsCardView.LayoutState) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = layoutState.cornerRadius
        if let wrappedView = closeButton.superview {
            wrappedView.isHidden = layoutState.shouldCloseButtonHide
        }
    }

    // MARK: - Private Function

    @objc private func closeButtonTapped() {
        self.delegate?.closeTopicsCard()
    }

    private func setupTopicsCardView() {

        // MEMO: 初期化時は折りたたんだ状態のレイアウトを適用する
        applyLayoutSettings(layoutState: LayoutState.collapsed)

        // MEMO: 戻るボタンのデザインを適用する
        let buttonImageSize = CGSize(width: 44.0, height: 44.0)
        let buttonImageColor: UIColor = UIColor(code: "#bcbcbc")
        closeButtonImageView.image = UIImage.fontAwesomeIcon(name: .timesCircle, style: .solid, textColor: buttonImageColor, size: buttonImageSize)
        closeButton.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
    }
}
