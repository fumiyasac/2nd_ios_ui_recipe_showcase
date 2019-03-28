//
//  CommentFloatingPanelBehavior.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/26.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import FloatingPanel

// MEMO: FloatingPanelの振る舞い設定に関するクラス
// → バネのような動きを表現するために定義している

final class CommentFloatingPanelBehavior: FloatingPanelBehavior {

    // MARK: - Computed Property

    // バネ運動のための相対直線速度の値
    var velocityThreshold: CGFloat {
        return 15.0
    }

    // MARK: - Function

    // 表示時のアニメーションに関する処理を定義する
    func interactionAnimator(_ fpc: FloatingPanelController, to targetPosition: FloatingPanelPosition, with velocity: CGVector) -> UIViewPropertyAnimator {
        let timing = timeingCurve(to: targetPosition, with: velocity)

        // UIViewPropertyAnimatorを利用してバネ運動のような動きを付与する
        return UIViewPropertyAnimator(duration: 0, timingParameters: timing)
    }

    // MARK: - Private Function

    // バネ運動のタイミングに関する値を設定する
    private func timeingCurve(to: FloatingPanelPosition, with velocity: CGVector) -> UITimingCurveProvider {
        let damping = self.damping(with: velocity)
        return UISpringTimingParameters(dampingRatio: damping, frequencyResponse: 0.4, initialVelocity: velocity)
    }

    // バネ運動の調整値を決める
    private func damping(with velocity: CGVector) -> CGFloat {
        switch velocity.dy {
        case ...(-velocityThreshold):
            return 0.7
        case velocityThreshold...:
            return 0.7
        default:
            return 1.0
        }
    }
}
