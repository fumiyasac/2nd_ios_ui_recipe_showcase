//
//  CommentFloatingPanelLayout.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/26.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import FloatingPanel

// MEMO:

final class CommentFloatingPanelLayout: FloatingPanelLayout {

    // MARK: - Computed Property

    //
    var initialPosition: FloatingPanelPosition {
        return .tip
    }

    //
    var topInteractionBuffer: CGFloat {
        return 0.0
    }

    //
    var bottomInteractionBuffer: CGFloat {
        return 0.0
    }

    // MARK: - Function

    //
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full:
            return 0.0
        case .half:
            return 246.0
        case .tip:
            return 64.0
        default:
            return nil
        }
    }
}
