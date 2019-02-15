//
//  MainTabBarAnimations.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import TransitionableTab

// ライブラリ:TransitionableTabでのアニメーション定義
// ※1) case move, fade, scaleはすでに用意されている
// ※2) case custom を作成して自前の動きを作ることも可能
enum MainTabBarAnimations {

    case move
    case fade
    case scale

    // MARK: - Function

    func getBackAnimationWhenSelectedIndex(layer: CALayer?, direction: Direction) -> CAAnimation {
        switch self {
        case .move:
            return DefineAnimation.move(.from, direction: direction)
        case .scale:
            return DefineAnimation.scale(.from)
        case .fade:
            return DefineAnimation.fade(.from)
        }
    }

    func getForwardAnimationWhenSelectedIndex(layer: CALayer?, direction: Direction) -> CAAnimation {
        switch self {
        case .move:
            return DefineAnimation.move(.to, direction: direction)
        case .scale:
            return DefineAnimation.scale(.to)
        case .fade:
            return DefineAnimation.fade(.to)
        }
    }
}
