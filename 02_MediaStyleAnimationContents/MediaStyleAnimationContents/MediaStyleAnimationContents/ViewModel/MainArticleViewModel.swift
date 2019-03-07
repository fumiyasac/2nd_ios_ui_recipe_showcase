//
//  MainArticleViewModel.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/06.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import SwiftyJSON

final class MainArticleViewModel {

    // ViewController側で受信できるNotification名を定義する
    let executingFetchMainArticle = Notification.Name(ViewModelNotification.executingFetchMainArticle.rawValue)
    let successFetchMainArticle = Notification.Name(ViewModelNotification.successFetchMainArticle.rawValue)
    let failureFetchMainArticle = Notification.Name(ViewModelNotification.failureFetchMainArticle.rawValue)

    // 初期化時に外部から渡されるインスタンス
    private let notificationCenter: NotificationCenter
    private let api: APIManagerProtocol

    // APIから取得したSlider部分に表示するデータ保持用の変数
    private (set)var targetMainArticleLists: [MainArticleEntity] = []
    // 最終ページに到達したかを判定するフラグ
    private (set)var hasNextPage: Bool = true

    // 現在のページ数
    private var currentPage: Int = 1

    // MARK: - Enum

    private enum ViewModelNotification: String {
        case executingFetchMainArticle = "ExecutingFetchMainArticle"
        case successFetchMainArticle = "SuccessFetchMainArticle"
        case failureFetchMainArticle = "FailureFetchMainArticle"
    }

    // MARK: - Initializer

    init(notificationCenter: NotificationCenter, api: APIManagerProtocol) {
        self.notificationCenter = notificationCenter
        self.api = api
    }

    // MARK: - Function

    func fetchMainSlider()  {

        // 次のページが存在しない場合は以降の処理を実行しない
        if !hasNextPage {
            return
        }

        // 写真データをAPIから取得する(詳細表示用)
        api.getArticleList(perPage: currentPage)
            .done{ json in

                // データ保持用の変数へJSONから取得したデータを整形して格納する
                // 1. 次のページが存在するかの判定
                self.hasNextPage = MainArticle.getHasNextPage(json)
                // 2. 記事10件分
                let responseResult = MainArticle.getMainArticleList(json).map {
                    self.targetMainArticleLists.append($0)
                }

                // 現在のページ数に+1加算する
                self.currentPage += 1

                // データ取得処理成功時のNotification送信
                self.notificationCenter.post(name: self.successFetchMainArticle, object: nil)
                print(responseResult)
            }
            .catch { error in

                // データ取得処理失敗時のNotification送信
                self.notificationCenter.post(name: self.failureFetchMainArticle, object: nil)
                print(error.localizedDescription)
        }
    }
}
