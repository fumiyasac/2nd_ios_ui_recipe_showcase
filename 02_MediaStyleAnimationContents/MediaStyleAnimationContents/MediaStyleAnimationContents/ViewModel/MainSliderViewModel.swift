//
//  MainSliderViewModel.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/05.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import SwiftyJSON

final class MainSliderViewModel {

    // ViewController側で受信できるNotification名を定義する
    let successFetchMainSlider = Notification.Name(ViewModelNotification.successFetchMainSlider.rawValue)
    let failureFetchMainSlider = Notification.Name(ViewModelNotification.failureFetchMainSlider.rawValue)

    // 初期化時に外部から渡されるインスタンス
    private let notificationCenter: NotificationCenter
    private let api: APIManagerProtocol

    // APIから取得したSlider部分に表示するデータ保持用の変数
    private (set)var targetMainSliderLists: [MainSliderEntity] = []

    // MARK: - Enum

    private enum ViewModelNotification: String {
        case successFetchMainSlider = "SuccessFetchMainSlider"
        case failureFetchMainSlider = "FailureFetchMainSlider"
    }
    
    // MARK: - Initializer

    init(notificationCenter: NotificationCenter, api: APIManagerProtocol) {
        self.notificationCenter = notificationCenter
        self.api = api
    }

    // MARK: - Function

    func fetchMainSlider()  {

        // スライダー表示用データをAPIから取得する
        api.getSliderImages()

            // 成功時の処理をクロージャー内に記載する
            .done{ json in

                // データ保持用の変数へJSONから取得したデータを整形して格納する
                let responseResult = MainSlider.getMainSliderList(json)
                self.targetMainSliderLists = responseResult

                // データ取得処理成功時のNotification送信
                self.notificationCenter.post(name: self.successFetchMainSlider, object: nil)
                print("スライド画像一覧データ取得成功:", responseResult)
            }

            // 失敗時の処理をクロージャー内に記載する
            .catch { error in

                // データ取得処理失敗時のNotification送信
                self.notificationCenter.post(name: self.failureFetchMainSlider, object: nil)
                print("スライド画像一覧データ取得失敗:", error.localizedDescription)
            }
    }
}
