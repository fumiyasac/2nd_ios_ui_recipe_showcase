//
//  MockArticleAPIManager.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/06.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit

class MockArticleAPIManager {

    // MARK: - Singleton Instance

    static let shared = MockArticleAPIManager()

    private init() {}

    enum FileName: String {
        case sliders = "sliders"
        case list = "list"
        case detail = "detail"
        case recommend = "recommend"
    }
}

// MARK: - APIManagerProtocol

extension MockArticleAPIManager: APIManagerProtocol {

    // MARK: - Function

    func getSliderImages() -> Promise<JSON> {
        if let path = getStubFilePath(jsonFileName: MockArticleAPIManager.FileName.sliders.rawValue) {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            return Promise { seal in
                seal.fulfill(JSON(data))
            }
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }

    func getArticleList(perPage: Int) -> Promise<JSON> {
        let targetFileName = MockArticleAPIManager.FileName.list.rawValue + String(perPage)
        if let path = getStubFilePath(jsonFileName: targetFileName) {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            return Promise { seal in
                seal.fulfill(JSON(data))
            }
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }

    func getArticleBy(id: Int) -> Promise<JSON> {
        let targetFileName = MockArticleAPIManager.FileName.detail.rawValue + String(id)
        if let path = getStubFilePath(jsonFileName: targetFileName) {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            return Promise { seal in
                seal.fulfill(JSON(data))
            }
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }

    func getRecommends() -> Promise<JSON> {
        if let path = getStubFilePath(jsonFileName: MockArticleAPIManager.FileName.recommend.rawValue) {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            return Promise { seal in
                seal.fulfill(JSON(data))
            }
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }

    // MARK: - Private Function

    // プロジェクト内にBundleされているStub用のJSONのファイルパスを取得する
    private func getStubFilePath(jsonFileName: String) -> String? {
        return Bundle.main.path(forResource: jsonFileName, ofType: "json")
    }
}
