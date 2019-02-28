//
//  QiitaContentsLists.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/28.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation

enum QiitaContentsLists: CaseIterable {

    case passcodeLock, rxswiftUsage, infiniteTab, reduxUsage, likeTinder

    // MARK: - Function

     func getUrl() -> URL? {
        let baseUri = "https://qiita.com/fumiyasac@github/items/"
        var targetUrl: String
        switch self {
        case .passcodeLock:
            targetUrl = baseUri + "6124f9b272f5ee6ebb40"
        case .rxswiftUsage:
            targetUrl = baseUri + "e426d321fbb8ab846bb6"
        case .infiniteTab:
            targetUrl = baseUri + "af4fed8ea4d0b94e6bc4"
        case .reduxUsage:
            targetUrl = baseUri + "f25465a955afdcb795a2"
        case .likeTinder:
            targetUrl = baseUri + "c68b7ce812bf3ef48a67"
        }
        return URL(string: targetUrl)
    }

    func getTitle() -> String {
        switch self {
        case .passcodeLock:
            return "パスコード画面ロック"
        case .rxswiftUsage:
            return "RxSwiftを使ったUI表現"
        case .infiniteTab:
            return "無限Scrollするタブ型UI"
        case .reduxUsage:
            return "Reduxでの複雑な画面実装"
        case .likeTinder:
            return "TinderのようなUI表現"
        }
    }
}
