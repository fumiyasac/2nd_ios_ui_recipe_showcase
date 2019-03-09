//
//  DetailViewModel.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/09.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import SwiftyJSON

final class DetailViewModel {

    // ViewController側で受信できるNotification名を定義する
    let successFetchArticleById = Notification.Name(ViewModelNotification.successFetchArticleById.rawValue)
    let failureFetchArticleById = Notification.Name(ViewModelNotification.failureFetchArticleById.rawValue)
    let successFetchDetailRecommend = Notification.Name(ViewModelNotification.successFetchDetailRecommend.rawValue)
    let failureFetchDetailRecommend = Notification.Name(ViewModelNotification.failureFetchDetailRecommend.rawValue)

    // 初期化時に外部から渡されるインスタンス
    private let notificationCenter: NotificationCenter
    private let api: APIManagerProtocol

    // APIから取得した渡された記事IDに紐づく記事データ保持用の変数
    private (set)var targetDetailArticle: MainArticleEntity? = nil
    // APIから取得した渡されたおすすめ表示用データ保持用の変数
    private (set)var targetDetailRecommendLists: [DetailRecommendEntity] = []

    // MARK: - Enum

    private enum ViewModelNotification: String {
        case successFetchArticleById = "SuccessFetchArticleById"
        case failureFetchArticleById = "FailureFetchArticleById"
        case successFetchDetailRecommend = "SuccessFetchDetailRecommend"
        case failureFetchDetailRecommend = "FailureFetchDetailRecommend"
    }

    // MARK: - Initializer

    init(notificationCenter: NotificationCenter, api: APIManagerProtocol) {
        self.notificationCenter = notificationCenter
        self.api = api
    }

    // MARK: - Function

    func fetchDetailArtcleBy(targetId: Int)  {

        // 記事詳細表示用データをAPIから取得する
        api.getArticleBy(id: targetId)

            // 成功時の処理をクロージャー内に記載する
            .done{ json in

                // データ保持用の変数へJSONから取得したデータを整形して格納する
                let responseResult = MainArticle.getSingleArticle(json)
                self.targetDetailArticle = responseResult

                // データ取得処理成功時のNotification送信
                self.notificationCenter.post(name: self.successFetchArticleById, object: nil)
                print("記事詳細データ取得成功:", responseResult)
            }

            // 失敗時の処理をクロージャー内に記載する
            .catch { error in

                // データ取得処理失敗時のNotification送信
                self.notificationCenter.post(name: self.failureFetchArticleById, object: nil)
                print("記事詳細データ取得失敗:", error.localizedDescription)
            }
    }

    func fetchRecommend()  {

        // 記事詳細表示用おすすめデータをAPIから取得する(詳細表示用)
        api.getRecommends()

            // 成功時の処理をクロージャー内に記載する
            .done{ json in

                // データ保持用の変数へJSONから取得したデータを整形して格納する
                let responseResult = DetailRecommend.getDetailRecommendList(json)
                self.targetDetailRecommendLists = responseResult

                // データ取得処理成功時のNotification送信
                self.notificationCenter.post(name: self.successFetchDetailRecommend, object: nil)
                print("おすすめデータ取得成功:", responseResult)
            }

            // 失敗時の処理をクロージャー内に記載する
            .catch { error in

                // データ取得処理失敗時のNotification送信
                self.notificationCenter.post(name: self.failureFetchDetailRecommend, object: nil)
                print("おすすめデータ取得失敗:", error.localizedDescription)
            }
    }
}
