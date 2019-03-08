//
//  ArticleCategoryLists.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

enum ArticleCategoryLists: Int, CaseIterable {

    case normal = 0, new, event, menu

    // MARK: - Function

    func getDisplayName() -> String {
        switch self {
        case .new:
            return "最新記事"
        case .event:
            return "イベント"
        case .menu:
            return "メニュー"
        default:
            return "紹介記事"
        }
    }

    func getLabelColor() -> UIColor {
        switch self {
        case .new:
            return UIColor(code: "#71b174")
        case .event:
            return UIColor(code: "#dd9dbf")
        case .menu:
            return UIColor(code: "#d78114")
        default:
            return UIColor(code: "#ff7e79")
        }
    }
}
