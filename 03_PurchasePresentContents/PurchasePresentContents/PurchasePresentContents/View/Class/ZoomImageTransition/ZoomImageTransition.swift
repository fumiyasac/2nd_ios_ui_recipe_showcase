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

// MEMO: TransitionAnimatableはライブラリ「ARNTransitionAnimator」で提供されるもの

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

    //
    func prepareContainer(_ transitionType: TransitionType, containerView: UIView, from fromVC: UIViewController, to toVC: UIViewController) {

        //
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

        //
        fromVC.view.setNeedsLayout()
        fromVC.view.layoutIfNeeded()
        toVC.view.setNeedsLayout()
        toVC.view.layoutIfNeeded()
    }

    //
    func willAnimation(_ transitionType: TransitionType, containerView: UIView) {

        //
        if transitionType.isPresenting {

            //
            sourceImageView = rootVC.createTransitionImageView()
            destinationImageView = modalVC.createTransitionImageView()

            //
            containerView.addSubview(sourceImageView)

            //
            rootVC.presentationBeforeAction()
            modalVC.presentationBeforeAction()

            //
            modalVC.view.alpha = 0.0

        } else {

            //
            sourceImageView = modalVC.createTransitionImageView()
            destinationImageView = rootVC.createTransitionImageView()

            //
            sourceFrame = sourceImageView.frame
            destFrame = destinationImageView.frame

            //
            containerView.addSubview(sourceImageView)

            //
            rootVC.dismissalBeforeAction()
            modalVC.dismissalBeforeAction()
        }
    }

    //
    func updateAnimation(_ transitionType: TransitionType, percentComplete: CGFloat) {

        //
        if transitionType.isPresenting {

            //
            sourceImageView.frame = destinationImageView.frame

            //
            modalVC.view.alpha = 1.0 * percentComplete

            //
            rootVC.presentationAnimationAction(percentComplete: percentComplete)
            modalVC.presentationAnimationAction(percentComplete: percentComplete)

        } else {

            //
            let p = 1.0 - (1.0 * percentComplete)
            modalVC.view.alpha = p

            //
            let frame = CGRect(
                x: destFrame.origin.x - (destFrame.origin.x - sourceFrame.origin.x) * p,
                y: destFrame.origin.y - (destFrame.origin.y - sourceFrame.origin.y) * p,
                width: destFrame.size.width + (sourceFrame.size.width - destFrame.size.width) * p,
                height: destFrame.size.height + (sourceFrame.size.height - destFrame.size.height) * p
            )
            sourceImageView.frame = frame

            //
            rootVC.dismissalAnimationAction(percentComplete: percentComplete)
            modalVC.dismissalAnimationAction(percentComplete: percentComplete)
        }
    }

    //
    func finishAnimation(_ transitionType: TransitionType, didComplete: Bool) {

        //
        sourceImageView.removeFromSuperview()
        destinationImageView.removeFromSuperview()

        //
        if transitionType.isPresenting {
            rootVC.presentationCompletionAction(didComplete: didComplete)
            modalVC.presentationCompletionAction(didComplete: didComplete)
        } else {
            rootVC.dismissalCompletionAction(didComplete: didComplete)
            modalVC.dismissalCompletionAction(didComplete: didComplete)
        }

        //
        rootVC.view.setNeedsDisplay()
        animationCompletion?(didComplete)
    }
}

// MEMO: TransitionAnimatableはライブラリ「ARNTransitionAnimator」で提供されるもの

// MARK: - ZoomImageTransition

extension ZoomImageTransition {

    // MARK: - Function

    //
    func sourceVC() -> UIViewController {
        return rootVC
    }

    //
    func destVC() -> UIViewController {
        return modalVC
    }
}
