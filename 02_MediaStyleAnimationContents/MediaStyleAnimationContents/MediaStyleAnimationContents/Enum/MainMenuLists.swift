//
//  MainMenuLists.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import FontAwesome_swift

enum MainMenuLists: CaseIterable {

    case profile, qiita

    // MARK: - Function

    func getStoryboardName() -> String {
        switch self {
        case .profile:
            return "Profile"
        case .qiita:
            return "Qiita"
        }
    }

    func getTitle() -> String {
        switch self {
        case .profile:
            return "自己紹介とソーシャルリンク集"
        case .qiita:
            return "その他実装の参考Qiita資料集"
        }
    }

    func getIcon() -> FontAwesome {
        switch self {
        case .profile:
            return .smile
        case .qiita:
            return .fileAlt
        }
    }
}
