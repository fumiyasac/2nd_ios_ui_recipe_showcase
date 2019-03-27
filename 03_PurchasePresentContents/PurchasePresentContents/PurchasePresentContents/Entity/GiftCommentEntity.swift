//
//  GiftCommentEntity.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/27.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation

// MEMO: こちらのデータはJSONから生成する
struct GiftCommentEntity: Decodable {

    let id: Int
    let author: String
    let rating: Double
    let comment: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case author
        case rating
        case comment
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.comment = try container.decode(String.self, forKey: .comment)
    }
}
