//
//  MediaStyleAnimationContentsTests.swift
//  MediaStyleAnimationContentsTests
//
//  Created by 酒井文也 on 2019/02/10.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import XCTest
@testable import MediaStyleAnimationContents

// MEMO: 今回はAPIからの取得と表示用データ作成が行えているかのテストを実施

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
        fetchMainSliderLists(viewModel: viewModel, timeOutSec: 15.0)
    }

    // Case2: 記事データの取得処理に関するテスト
    func testMainArticleViewModel() {

        // 必要なViewModelを初期化する(APIアクセス部分はMockを利用)
        let viewModel = MainArticleViewModel(notificationCenter: NotificationCenter(), api: MockArticleAPIManager.shared)

        // フェッチを実行前の初期状態
        XCTAssertEqual(0, viewModel.targetMainArticleLists.count, "フェッチ実行前は変数:targetMainArticleListsの総数は0となること")
        XCTAssertTrue(viewModel.hasNextPage, "フェッチ実行前は変数:hasNextPageはtrueとなること")

        // 記事データのフェッチを実行する
        for page in 1...3 {
            fetchMainArticleLists(page: page, viewModel: viewModel, timeOutSec: 15.0)
        }
    }

    // Case3: 詳細ページのデータの取得処理に関するテスト
    func testDetailViewModel() {
        
        // 必要なViewModelを初期化する(APIアクセス部分はMockを利用)
        let viewModel = DetailViewModel(notificationCenter: NotificationCenter(), api: MockArticleAPIManager.shared)

        // フェッチを実行前の初期状態
        XCTAssertNil(viewModel.targetDetailArticle, "フェッチ実行前は変数:targetDetailArticleはnilとなること")
        XCTAssertEqual(0, viewModel.targetDetailRecommendLists.count, "フェッチ実行前は変数:targetDetailRecommendListsの総数は0となること")

        // 対象のIDに紐づく記事データのフェッチを実行する
        let targetId = Int.random(in: 1 ... 30)
        fetchDetailArticleBy(id: targetId, viewModel: viewModel, timeOutSec: 15.0)

        // おすすめ記事データのフェッチを実行する
        fetchRecommend(viewModel: viewModel, timeOutSec: 15.0)
    }

    // MARK: - Private Function

    // Case1: スライダー表示用画像データの取得処理を実行
    private func fetchMainSliderLists(viewModel: MainSliderViewModel, timeOutSec: TimeInterval) {

        let expectation: XCTestExpectation? = self.expectation(description: "fetchMainSliderExpectation")

        // サブスレッドでViewModelのメソッドを実行する
        DispatchQueue.global().async {
            viewModel.fetchMainSlider()
            DispatchQueue.main.async {
                expectation?.fulfill()
            }
        }

        // 引数で指定したタイムアウト時間内に処理された場合の検証を実行する
        waitForExpectations(timeout: timeOutSec, handler: { _ in

            // MEMO: ViewModelの変数:targetMainSliderListsにスタブのJSONファイルから取得したデータが反映されているかを確認する
            XCTAssertEqual(6, viewModel.targetMainSliderLists.count, "フェッチ実行前は変数:targetMainSliderListsの総数は6となること")
        })
    }

    // Case2: 記事データの取得処理を実行
    private func fetchMainArticleLists(page: Int, viewModel: MainArticleViewModel, timeOutSec: TimeInterval) {

        let descriptionName = "fetchMainSliderExpectation\(page)"
        let expectation: XCTestExpectation? = self.expectation(description: descriptionName)

        // サブスレッドでViewModelのメソッドを実行する
        DispatchQueue.global().async {
            viewModel.fetchMainArtcle()
            DispatchQueue.main.async {
                expectation?.fulfill()
            }
        }

        // 引数で指定したタイムアウト時間内に処理された場合の検証を実行する
        waitForExpectations(timeout: timeOutSec, handler: { _ in

            // テスト結果として期待する値や結果に関する定義
            let expectedCount = 10 * page
            let expectedHasNextPage = (page < 3)

            // MEMO: ViewModelの変数:targetMainArticleLists・変数:hasNextPageにスタブのJSONファイルから取得したデータが反映されているかを確認する
            XCTAssertEqual(expectedCount, viewModel.targetMainArticleLists.count, "フェッチ実行後は変数:targetMainArticleListsの総数が期待した数と等しくなること")
            XCTAssertEqual(expectedHasNextPage, viewModel.hasNextPage, "フェッチ実行後は変数:hasNextPageが期待した数と等しくなること")
        })
    }

    // Case3: 詳細ページのデータの取得処理を実行する(その1)
    private func fetchDetailArticleBy(id: Int, viewModel: DetailViewModel, timeOutSec: TimeInterval) {
        
        let descriptionName = "fetchArticleById\(id)"
        let expectation: XCTestExpectation? = self.expectation(description: descriptionName)

        // サブスレッドでViewModelのメソッドを実行する
        DispatchQueue.global().async {
            viewModel.fetchDetailArtcleBy(targetId: id)
            DispatchQueue.main.async {
                expectation?.fulfill()
            }
        }

        // 引数で指定したタイムアウト時間内に処理された場合の検証を実行する
        waitForExpectations(timeout: timeOutSec, handler: { _ in

            // テスト結果として期待する値や結果に関する定義
            let expectedResult = (id == viewModel.targetDetailArticle?.id)

            // MEMO: ViewModelの変数:targetDetailArticleで引数で渡したIDと取得データのIDが等しいかを確認する
            XCTAssertTrue(expectedResult, "引数で渡したIDと取得データのIDが等しくなること")
        })
    }

    // Case3: 詳細ページのデータの取得処理を実行する(その2)
    private func fetchRecommend(viewModel: DetailViewModel, timeOutSec: TimeInterval) {

        let descriptionName = "fetchRecommend"
        let expectation: XCTestExpectation? = self.expectation(description: descriptionName)

        // サブスレッドでViewModelのメソッドを実行する
        DispatchQueue.global().async {
            viewModel.fetchRecommend()
            DispatchQueue.main.async {
                expectation?.fulfill()
            }
        }

        // 引数で指定したタイムアウト時間内に処理された場合の検証を実行する
        waitForExpectations(timeout: timeOutSec, handler: { _ in

            // MEMO: ViewModelの変数:targetDetailRecommendListsにスタブのJSONファイルから取得したデータが反映されているかを確認する
            XCTAssertEqual(6, viewModel.targetDetailRecommendLists.count, "フェッチ実行前は変数:targetDetailRecommendListsの総数は6となること")
        })
    }
}
