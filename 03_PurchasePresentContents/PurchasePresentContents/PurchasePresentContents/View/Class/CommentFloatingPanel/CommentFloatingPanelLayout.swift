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

    // 初期化時のハーフモーダル位置の表示状態
    var initialPosition: FloatingPanelPosition {
        return .tip
    }

    // 上部のドラッグ可能位置におけるずれのバッファ値
    var topInteractionBuffer: CGFloat {
        return 0.0
    }

    // 下部のドラッグ可能位置におけるずれのバッファ値
    var bottomInteractionBuffer: CGFloat {
        return 0.0
    }

    // MARK: - Function

    // 全画面時・半分時・一番下部時の位置を決定する
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full:
            // MEMO: 上部SafeAreaからの位置
            return 0.0
        case .half:
            // MEMO: 下部SafeAreaからの位置
            return 246.0
        case .tip:
            // MEMO: 下部SafeAreaからの位置
            return 64.0
        default:
            return nil
        }
    }
}
