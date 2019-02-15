//
//  MainTabBarItems.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

// MainTabBarControllerへ配置するものに関する設定
enum MainTabBarItems: CaseIterable {

    case topics
    case news
    case photos
    case timetable

    // MARK: - Function

    // 該当のViewControllerを取得する
    func getViewController() -> UIViewController? {
        var storyboardName: String
        switch self {
        case .topics:
            storyboardName = "Topics"
        case .news:
            storyboardName = "News"
        case .photos:
            storyboardName = "PhotoGallery"
        case .timetable:
            storyboardName = "TimeTable"
        }
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
    }

    // MainTabBarのインデックス番号を取得する
    func getTabIndex() -> Int {
        switch self {
        case .topics:
            return 0
        case .news:
            return 1
        case .photos:
            return 2
        case .timetable:
            return 3
        }
    }

    // MainTabBarのタイトルを取得する
    func getTitle() -> String {
        switch self {
        case .topics:
            return "トピックス"
        case .news:
            return "ニュース"
        case .photos:
            return "ギャラリー"
        case .timetable:
            return "番組表"
        }
    }

    // TabBarに使うFontAwesomeアイコン名を取得する
    func getFontAwesomeIcon() -> FontAwesome {
        switch self {
        case .topics:
            return .hamburger
        case .news:
            return .newspaper
        case .photos:
            return .images
        case .timetable:
            return .calendarAlt
        }
    }
}

