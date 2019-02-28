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

    case archive, qiita

    // MARK: - Function

    func getStoryboardName() -> String {
        switch self {
        case .archive:
            return "Archive"
        case .qiita:
            return "Qiita"
        }
    }

    func getIcon() -> FontAwesome {
        switch self {
        case .archive:
            return .archive
        case .qiita:
            return .fileAlt
        }
    }

    func getTitle() -> String {
        switch self {
        case .archive:
            return "アーカイブした記事一覧"
        case .qiita:
            return "その他実装の参考資料集"
        }
    }
}
