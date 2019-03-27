//
//  GalleryPresenter.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation

// MEMO: このPresenterの処理実行時にViewController側で行う処理のプロトコル定義
protocol GalleryPresenterProtocol: class {

    // BundleされたJSONから取得したデータを整形した配列データを送る
    func serveGalleryList(_ galleries: [GalleryEntity])
}

class GalleryPresenter {

    var presenter: GalleryPresenterProtocol!

    // MARK: - Initializer

    init(presenter: GalleryPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Functions

    // サンプル用データを取得する
    func getGalleries() {

        // JSONファイルを取得してGiftCommentEntityの型に合致するように整形した配列データを作成する
        let galleries = try! JSONDecoder().decode([GalleryEntity].self, from: getDataFromJSONFile())

        // プロトコルを適用したViewController側に整形した配列データを送る
        self.presenter.serveGalleryList(galleries)
    }

    // MARK: - Private Functions

    // JSONファイルで定義されたデータを読み込んでData型で返す
    private func getDataFromJSONFile() -> Data {
        if let path = Bundle.main.path(forResource: "galleries", ofType: "json") {
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }
}
