//
//  GiftPresenter.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation

// MEMO: このPresenterの処理実行時にViewController側で行う処理のプロトコル定義
protocol GiftPresenterProtocol: class {

    // BundleされたJSONから取得したデータを整形した配列データを送る
    func serveGiftListBySectionType(_ gifts: [GiftEntity])
}

class GiftPresenter {

    var presenter: GiftPresenterProtocol!

    // MARK: - Initializer

    init(presenter: GiftPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Functions

    // サンプル用データを取得する
    func getGiftListBy(targetSectionType: MainSectionType) {

        // JSONファイルを取得してGiftCommentEntityの型に合致するように整形した配列データを作成する
        let gifts = try! JSONDecoder().decode([GiftEntity].self, from: getDataFromJSONFileBy(sectionType: targetSectionType))

        // プロトコルを適用したViewController側に整形した配列データを送る
        self.presenter.serveGiftListBySectionType(gifts)
    }

    // MARK: - Private Functions

    // JSONファイルで定義されたデータを読み込んでData型で返す
    private func getDataFromJSONFileBy(sectionType: MainSectionType) -> Data {

        // MEMO: 一覧表示のセクション分類をしたEnumから該当するJSONファイルの名前を取得する
        if let path = Bundle.main.path(forResource: sectionType.getJsonFileName(), ofType: "json") {
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }
}
