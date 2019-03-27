//
//  GiftCommentPresenter.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/27.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation

// MEMO: このPresenterの処理実行時にViewController側で行う処理のプロトコル定義
protocol GiftCommentPresenterProtocol: class {

    // BundleされたJSONから取得したデータを整形した配列データを送る
    func serveGiftCommentList(_ giftComments: [GiftCommentEntity])
}

class GiftCommentPresenter {

    var presenter: GiftCommentPresenterProtocol!

    // MARK: - Initializer

    init(presenter: GiftCommentPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Functions

    // サンプル用データを取得する
    func getAllGiftComments() {

        // JSONファイルを取得してGiftCommentEntityの型に合致するように整形した配列データを作成する
        let giftComments = try! JSONDecoder().decode([GiftCommentEntity].self, from: getDataFromJSONFile())

        // プロトコルを適用したViewController側に整形した配列データを送る
        self.presenter.serveGiftCommentList(giftComments)
    }

    // MARK: - Private Functions

    // JSONファイルで定義されたデータを読み込んでData型で返す
    private func getDataFromJSONFile() -> Data {
        if let path = Bundle.main.path(forResource: "gift_comments", ofType: "json") {
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }
}
