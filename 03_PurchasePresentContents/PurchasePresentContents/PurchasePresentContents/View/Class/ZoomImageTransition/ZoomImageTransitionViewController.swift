//
//  ZoomImageTransitionViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MEMO: UIViewControllerを継承したクラスを定義してZoomImageTransitionProtocolのメソッドを利用できる形にする
// https://github.com/xxxAIRINxxx/ARNZoomImageTransition

class ZoomImageTransitionViewController: UIViewController, ZoomImageTransitionProtocol {}

// MARK: - ZoomImageTransitionProtocol

extension ZoomImageTransitionViewController {

    // MARK: - Function

    @objc func createTransitionImageView() -> UIImageView {
        return UIImageView()
    }

    @objc func presentationBeforeAction() {}

    @objc func presentationAnimationAction(percentComplete: CGFloat) {}

    @objc func presentationCancelAnimationAction() {}

    @objc func presentationCompletionAction(didComplete: Bool) {}

    @objc func dismissalBeforeAction() {}

    @objc func dismissalAnimationAction(percentComplete: CGFloat) {}

    @objc func dismissalCancelAnimationAction() {}

    @objc func dismissalCompletionAction(didComplete: Bool) {}
}
