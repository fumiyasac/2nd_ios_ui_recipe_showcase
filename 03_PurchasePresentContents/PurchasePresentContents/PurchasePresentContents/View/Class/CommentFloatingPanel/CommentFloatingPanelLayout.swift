//
//  CommentFloatingPanelLayout.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/26.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import FloatingPanel

// MEMO: FloatingPanelのレイアウト設定に関するクラス

final class CommentFloatingPanelLayout: FloatingPanelLayout {

    // MARK: - Computed Property

    // 制約の基準値に関する設定
    var position: FloatingPanelPosition {
        return .bottom
    }

    // 初期化時のハーフモーダル位置の表示状態
    var initialState: FloatingPanelState {
        return .tip
    }

    // 全画面時・半分時・一番下部時の位置を決定する
    // MEMO: 基準をSuperViewとする場合は「referenceGuide: .superview」とする
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full:
                // MEMO: 上部SafeAreaからの位置
                FloatingPanelLayoutAnchor(
                    absoluteInset: 0.0,
                    edge: .top,
                    referenceGuide: .safeArea
                ),
            .half:
                // MEMO: 下部SafeAreaからの位置
                FloatingPanelLayoutAnchor(
                    absoluteInset: 246.0,
                    edge: .bottom,
                    referenceGuide: .safeArea
                ),
            .tip:
                // MEMO: 下部SafeAreaからの位置
                FloatingPanelLayoutAnchor(
                    absoluteInset: 64.0,
                    edge: .bottom,
                    referenceGuide: .safeArea
                )
        ]
    }
}
