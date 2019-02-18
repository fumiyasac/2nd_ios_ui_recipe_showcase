//
//  NewsPresenter.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation

// 引数で渡されたニュース一覧をもとに画面表示処理を実行する
// → 該当ViewControllerへの橋渡し役
protocol NewsPresenterDelegate: NSObjectProtocol {
    func setNewsToScreen(_ news: [NewsModel])
}

final class NewsPresenter {

    weak var delegate: NewsPresenterDelegate?

    private let newsModels: [NewsModel]

    // MARK: - Initializer

    init() {
        if let path = Bundle.main.path(forResource: "news_datasource", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            self.newsModels = try! JSONDecoder().decode([NewsModel].self, from: data)
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }

    // MARK: - Function

    func getNewsList() {
        self.delegate?.setNewsToScreen(newsModels)
    }
}
