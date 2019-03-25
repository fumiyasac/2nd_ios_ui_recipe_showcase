//
//  CategoryType.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

enum CategoryType: Int, CaseIterable {

    case deli = 1, clothes, howsehold, interior, amenity, flower

    // MARK: - Function

    func getTitle() -> String {
        switch self {
        case .deli:
            return "DELI"
        case .clothes:
            return "CLOTHES"
        case .howsehold:
            return "HOUSEHOLD"
        case .interior:
            return "INTERIOR"
        case .amenity:
            return "AMENITY"
        case .flower:
            return "FLOWER"
        }
    }

    func getColor() -> UIColor {
        switch self {
        case .deli:
            return UIColor(code: "#ff803a")
        case .clothes:
            return UIColor(code: "#52cb52")
        case .howsehold:
            return UIColor(code: "#3fc5e2")
        case .interior:
            return UIColor(code: "#feca2c")
        case .amenity:
            return UIColor(code: "#ff6c6c")
        case .flower:
            return UIColor(code: "#706cdb")
        }
    }
}
