//
//  ArticleAPIManager.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class ArticleAPIManager {

    // MEMO: MockサーバーへのURLに関する情報
    private static let host = "http://localhost:3000/api"
    private static let version = "v1.0"
    private static let path = "articles"

    // MEMO: UserAgentに付加する情報の組み立て
    private static let bundleIdentifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    private static let requestHeader = [
        "User-Agent" : bundleIdentifier,
        "Content-Type" : "application/x-www-from-urlencoded"
    ]

    // MARK: - Singleton Instance

    static let shared = ArticleAPIManager()

    private init() {}

    // MARK: - Enum

    enum EndPoint: String {
        case sliders = "sliders"
        case list = "list"
        case detail = "detail"
        case recommend = "recommend"

        // MARK: - Function

        func getBaseUrl() -> String {
            return [host, version, path, self.rawValue].joined(separator: "/")
        }
    }
}

// MARK: - APIManagerProtocol

extension ArticleAPIManager: APIManagerProtocol {

    // MARK: - Function

    func getSliderImages() -> Promise<JSON> {
        let requestUrl = ArticleAPIManager.EndPoint.sliders.getBaseUrl()
        return handleArticlesApiRequest(url: requestUrl)
    }

    func getArticleList(perPage: Int) -> Promise<JSON> {
        let requestUrl = ArticleAPIManager.EndPoint.list.getBaseUrl() + "?page=" + String(perPage)
        return handleArticlesApiRequest(url: requestUrl)
    }

    func getArticleBy(id: Int) -> Promise<JSON> {
        let requestUrl = ArticleAPIManager.EndPoint.detail.getBaseUrl() + "?id=" + String(id)
        return handleArticlesApiRequest(url: requestUrl)
    }

    func getRecommends() -> Promise<JSON> {
        let requestUrl = ArticleAPIManager.EndPoint.recommend.getBaseUrl()
        return handleArticlesApiRequest(url: requestUrl)
    }

    // MARK: - Private Function

    // Promise型のデータを返却するための共通処理
    private func handleArticlesApiRequest(url: String, params: [String : Any] = [:]) -> Promise<JSON> {

        // MEMO: Alamofireでの通信処理をPromiseKitでラッピングする
        // 注意: iOS13以降では、Alamofireを利用する際の「encoding」は下記の様に設定する。
        // .getの場合はURLEncoding.default
        // .post,.put,.deleteはJSONEncoding.default

        return Promise { seal in
            Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: ArticleAPIManager.requestHeader).validate().responseJSON { response in

                switch response.result {

                // 成功時の処理(以降はレスポンス結果を取得して返す)
                case .success(let response):
                    let json = JSON(response)
                    seal.fulfill(json)

                // 失敗時の処理(以降はエラーの結果を返す)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
