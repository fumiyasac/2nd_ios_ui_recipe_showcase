//
//  APIManagerProtocol.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/06.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON

// MARK: - Protocol

protocol APIManagerProtocol {

    // トップに表示するスライダー画像一覧を取得する
    func getSliderImages() -> Promise<JSON>

    // 引数のページ番号に紐づく記事情報一覧を取得する
    func getArticleList(perPage: Int) -> Promise<JSON>

    // 引数のIDに紐づく記事情報を取得する
    func getArticleBy(id: Int) -> Promise<JSON>

    // おすすめ記事一覧を取得する
    func getRecommends() -> Promise<JSON>
}
