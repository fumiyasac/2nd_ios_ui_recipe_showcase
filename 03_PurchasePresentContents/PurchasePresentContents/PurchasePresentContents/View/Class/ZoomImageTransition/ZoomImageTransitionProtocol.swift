//
//  ZoomImageTransitionProtocol.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MEMO: ここでは該当のModal画面遷移にカスタムトランジションを適用するためのプロトコル

protocol ZoomImageTransitionProtocol: class {

    // 画像が浮き上がってくる動きの作成用のUIImageViewを生成する
    func createTransitionImageView() -> UIImageView

    // MEMO: 遷移元から遷移先へ移動する画面遷移時の処理

    // アニメーションの実行前に実行されるメソッド
    func presentationBeforeAction()

    // アニメーションの実行中に実行されるメソッド
    func presentationAnimationAction(percentComplete: CGFloat)

    // アニメーションの実行キャンセル時に実行されるメソッド
    func presentationCancelAnimationAction()

    // アニメーションの実行完了時に実行されるメソッド
    func presentationCompletionAction(didComplete: Bool)

    // MEMO: 遷移先から遷移元へ移動する画面遷移時の処理

    // アニメーションの実行前に実行されるメソッド
    func dismissalBeforeAction()

    // アニメーションの実行中に実行されるメソッド
    func dismissalAnimationAction(percentComplete: CGFloat)

    // アニメーションの実行キャンセル時に実行されるメソッド
    func dismissalCancelAnimationAction()

    // アニメーションの実行完了時に実行されるメソッド
    func dismissalCompletionAction(didComplete: Bool)
}
