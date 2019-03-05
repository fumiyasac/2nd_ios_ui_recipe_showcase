//
//  MediaStyleAnimationContentsTests.swift
//  MediaStyleAnimationContentsTests
//
//  Created by 酒井文也 on 2019/02/10.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import XCTest
@testable import MediaStyleAnimationContents

class MediaStyleAnimationContentsTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    // MARK: - Function

    // Case1: スライダー表示用画像データの取得処理に関するテスト
    func testMainSliderViewModel() {

        // 必要なViewModelを初期化する(APIアクセス部分はMockを利用)
        let viewModel = MainSliderViewModel(notificationCenter: NotificationCenter(), api: MockArticleAPIManager.shared)

        // フェッチを実行前の初期状態
        XCTAssertEqual(0, viewModel.targetMainSliderLists.count, "フェッチ実行前は変数:targetMainSliderListsの総数は0となること")

        // スライダー表示用画像データのフェッチを実行する
        fetchMainSlider(viewModel: viewModel, timeOutSec: 10.0)
    }

    // MARK: - Private Function

    // Case1: スライダー表示用画像データの取得処理を実行
    private func fetchMainSlider(viewModel: MainSliderViewModel, timeOutSec: TimeInterval) {

        let fetchMainSliderExpectation: XCTestExpectation? = self.expectation(description: "fetchMainSliderExpectation")

        // サブスレッドでViewModelのメソッドを実行する
        DispatchQueue.global().async {

            viewModel.fetchMainSlider()

            // メインスレッドでタイムアウト時間を超過した場合の処理を記載する
            DispatchQueue.main.async {
                fetchMainSliderExpectation?.fulfill()
            }
        }

        // 引数で指定したタイムアウト時間内に処理された場合の検証を実行する
        waitForExpectations(timeout: timeOutSec, handler: { _ in

            // MEMO: ViewModelの変数:targetMainSliderListsにスタブのJSONファイルから取得したデータが反映されているかを確認する
            XCTAssertEqual(6, viewModel.targetMainSliderLists.count, "フェッチ実行前は変数:targetMainSliderListsの総数は6となること")
        })
    }
}
