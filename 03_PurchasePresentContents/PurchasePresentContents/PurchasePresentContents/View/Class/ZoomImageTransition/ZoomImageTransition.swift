//
//  ZoomImageTransition.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import ARNTransitionAnimator

// MEMO: アニメーションを適用するためのカスタムクラスを定義する
// https://github.com/xxxAIRINxxx/ARNZoomImageTransition

// MEMO: TransitionAnimatableはライブラリ「ARNTransitionAnimator」で提供されるもの
// https://github.com/xxxAIRINxxx/ARNTransitionAnimator

final class ZoomImageTransition<T: UIViewController> : TransitionAnimatable where T : ZoomImageTransitionProtocol {

    var animationCompletion: ((Bool) -> Void)?

    private weak var rootVC: T!
    private weak var modalVC: T!
    private weak var rootNavigation: UINavigationController?

    private var sourceImageView: UIImageView!
    private var destinationImageView: UIImageView!

    private var sourceFrame: CGRect = CGRect.zero
    private var destFrame: CGRect = CGRect.zero

    // MARK: - Override

    init(rootVC: T, modalVC: T, rootNavigation: UINavigationController? = nil) {
        self.rootVC = rootVC
        self.modalVC = modalVC
        self.rootNavigation = rootNavigation
    }

    deinit {}

    // MARK: - Function

    // MEMO: TransitionAnimatableで定義されたプロトコルの実装を行う

    // 画面遷移時の動きを構成するためのContainerViewに関する設定を行う
    func prepareContainer(_ transitionType: TransitionType, containerView: UIView, from fromVC: UIViewController, to toVC: UIViewController) {

        // 遷移元→遷移先・遷移先→遷移元の場合で処理を分岐する
        if transitionType.isPresenting {
            containerView.addSubview(toVC.view)
        } else {
            if let rootView = rootNavigation?.view {
                containerView.addSubview(rootView)
            } else {
                containerView.addSubview(toVC.view)
            }
            containerView.addSubview(fromVC.view)
        }

        // 遷移元・遷移先の画面を描画する
        fromVC.view.setNeedsLayout()
        fromVC.view.layoutIfNeeded()
        toVC.view.setNeedsLayout()
        toVC.view.layoutIfNeeded()
    }

    // 画面遷移の実行直前に関する設定を行う
    func willAnimation(_ transitionType: TransitionType, containerView: UIView) {

        // 遷移元→遷移先・遷移先→遷移元の場合で処理を分岐する
        if transitionType.isPresenting {

            // 遷移元・遷移先におけるアニメーション対象のUIImageView要素
            sourceImageView = rootVC.createTransitionImageView()
            destinationImageView = modalVC.createTransitionImageView()

            // 遷移元のUIImageView要素を画面遷移時の動きを構成するためのContainerViewに追加する
            containerView.addSubview(sourceImageView)

            // 遷移元→遷移先の画面遷移の実行直前に行う処理を実行する
            rootVC.presentationBeforeAction()
            modalVC.presentationBeforeAction()

            // 画面遷移が実行される前は遷移先の画面のアルファ値を0にする
            modalVC.view.alpha = 0.0

        } else {

            // 遷移元・遷移先におけるアニメーション対象のUIImageView要素
            sourceImageView = modalVC.createTransitionImageView()
            destinationImageView = rootVC.createTransitionImageView()

            // 遷移元・遷移先におけるアニメーション対象のUIImageView要素からframe値を取得する
            sourceFrame = sourceImageView.frame
            destFrame = destinationImageView.frame

            // 遷移元のUIImageView要素を画面遷移時の動きを構成するためのContainerViewに追加する
            containerView.addSubview(sourceImageView)

            // 遷移先・遷移元の画面遷移の実行直前に行う処理を実行する
            rootVC.dismissalBeforeAction()
            modalVC.dismissalBeforeAction()
        }
    }

    // 画面遷移の実行中に関する設定を行う
    func updateAnimation(_ transitionType: TransitionType, percentComplete: CGFloat) {

        // 遷移元→遷移先・遷移先→遷移元の場合で処理を分岐する
        if transitionType.isPresenting {

            // 遷移元のUIImageViewのframe値を遷移先のUIImageViewのものに合わせる
            sourceImageView.frame = destinationImageView.frame

            // 遷移先の画面のアルファ値を徐々に小さくなるようにする
            modalVC.view.alpha = 1.0 * percentComplete

            // 遷移先・遷移元の画面遷移の実行中に関する設定を行う
            rootVC.presentationAnimationAction(percentComplete: percentComplete)
            modalVC.presentationAnimationAction(percentComplete: percentComplete)

        } else {

            // 遷移元の画面のアルファ値を徐々に大きくなるようにする
            let p = 1.0 - (1.0 * percentComplete)
            modalVC.view.alpha = p

            // 遷移元のUIImageViewにおいて元の場所のframe値を算出して適用する
            let frame = CGRect(
                x: destFrame.origin.x - (destFrame.origin.x - sourceFrame.origin.x) * p,
                y: destFrame.origin.y - (destFrame.origin.y - sourceFrame.origin.y) * p,
                width: destFrame.size.width + (sourceFrame.size.width - destFrame.size.width) * p,
                height: destFrame.size.height + (sourceFrame.size.height - destFrame.size.height) * p
            )
            sourceImageView.frame = frame

            // 遷移先・遷移元の画面遷移の実行中に関する設定を行う
            rootVC.dismissalAnimationAction(percentComplete: percentComplete)
            modalVC.dismissalAnimationAction(percentComplete: percentComplete)
        }
    }

    // 画面遷移の実行完了時に関する設定を行う
    func finishAnimation(_ transitionType: TransitionType, didComplete: Bool) {

        // 遷移元・遷移先におけるアニメーション対象のUIImageView要素を削除する
        sourceImageView.removeFromSuperview()
        destinationImageView.removeFromSuperview()

        // 遷移元→遷移先・遷移先→遷移元の場合で処理を分岐する
        if transitionType.isPresenting {

            // 遷移元から遷移先への画面遷移の実行完了時に関する設定を行う
            rootVC.presentationCompletionAction(didComplete: didComplete)
            modalVC.presentationCompletionAction(didComplete: didComplete)
        } else {

            // 遷移先から遷移元への画面遷移の実行完了時に関する設定を行う
            rootVC.dismissalCompletionAction(didComplete: didComplete)
            modalVC.dismissalCompletionAction(didComplete: didComplete)
        }

        // 遷移元のViewを描画する
        rootVC.view.setNeedsDisplay()

        // アニメーションが完了時にクロージャーで外から渡された処理を実行する
        animationCompletion?(didComplete)
    }
}

// MEMO: TransitionAnimatableはライブラリ「ARNTransitionAnimator」で提供されるもの

// MARK: - ZoomImageTransition

extension ZoomImageTransition {

    // MARK: - Function

    // 画面遷移元のUIViewControllerを返す
    func sourceVC() -> UIViewController {
        return rootVC
    }

    // 画面遷移先のUIViewControllerを返す
    func destVC() -> UIViewController {
        return modalVC
    }
}
