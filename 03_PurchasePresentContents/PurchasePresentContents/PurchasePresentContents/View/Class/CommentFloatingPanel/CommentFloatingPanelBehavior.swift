//
//  CommentFloatingPanelBehavior.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/26.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import FloatingPanel

// MEMO:

final class CommentFloatingPanelBehavior: FloatingPanelBehavior {

    // MARK: - Computed Property

    //
    var velocityThreshold: CGFloat {
        return 15.0
    }

    // MARK: - Function

    //
    func interactionAnimator(_ fpc: FloatingPanelController, to targetPosition: FloatingPanelPosition, with velocity: CGVector) -> UIViewPropertyAnimator {
        let timing = timeingCurve(to: targetPosition, with: velocity)
        return UIViewPropertyAnimator(duration: 0, timingParameters: timing)
    }

    // MARK: - Private Function

    //
    private func timeingCurve(to: FloatingPanelPosition, with velocity: CGVector) -> UITimingCurveProvider {
        let damping = self.damping(with: velocity)
        return UISpringTimingParameters(dampingRatio: damping, frequencyResponse: 0.4, initialVelocity: velocity)
    }

    //
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
