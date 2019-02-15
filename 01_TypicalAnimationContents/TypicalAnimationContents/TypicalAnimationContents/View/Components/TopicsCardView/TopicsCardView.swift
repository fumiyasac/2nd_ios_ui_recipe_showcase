//
//  TopicsCardView.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

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

        public static let collapsed = LayoutState(cornerRadius: 13.0, shouldCloseButtonHide: true)
        public static let expanded  = LayoutState(cornerRadius: 0.0, shouldCloseButtonHide: false)
    }

    // MARK: - Function
    
    // 引数で渡されたレイアウトに関する定義を適用する
    func applyLayoutSettings(layoutState: TopicsCardView.LayoutState) {
        self.layer.cornerRadius = layoutState.cornerRadius
        self.layer.masksToBounds = true
    }

    // MARK: - Private Function

    // MEMO: 初期化時は折りたたんだ状態のレイアウトを適用する
    private func setupTopicsCardView() {
        applyLayoutSettings(layoutState: LayoutState.collapsed)
    }
}
