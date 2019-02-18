//
//  TopicsPresenter.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation

// 引数で渡されたトピック一覧をもとに画面表示処理を実行する
// → 該当ViewControllerへの橋渡し役
protocol TopicsPresenterDelegate: NSObjectProtocol {
    func setTopicsToScreen(_ topics: [TopicsModel])
}

final class TopicsPresenter {

    weak var delegate: TopicsPresenterDelegate?

    private let topicsModels: [TopicsModel]

    // MARK: - Initializer

    init() {
        if let path = Bundle.main.path(forResource: "topics_datasource", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            self.topicsModels = try! JSONDecoder().decode([TopicsModel].self, from: data)
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }

    // MARK: - Function

    func getTopicsList() {
        self.delegate?.setTopicsToScreen(topicsModels)
    }
}
