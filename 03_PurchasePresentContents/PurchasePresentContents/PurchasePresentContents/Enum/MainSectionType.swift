//
//  MainSectionType.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

enum MainSectionType: Int, CaseIterable {

    case new = 0, special, monthly, recommend

    // MARK: - Function

    func getTitle() -> String {
        switch self {
        case .new:
            return "新着アイテム"
        case .special:
            return "卒業・入学シーズン特集"
        case .monthly:
            return "2019年4月の限定商品"
        case .recommend:
            return "あなたへのおすすめ"
        }
    }

    func getViewController() -> UIViewController {
        return MainSectionViewController.instantiate()
    }
}
