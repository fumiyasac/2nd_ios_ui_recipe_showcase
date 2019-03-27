//
//  GiftEntity.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/19.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation

// MEMO: こちらのデータはJSONから生成する
struct GiftEntity: Decodable {

    let id: Int
    let price: String
    let giftName: String
    let categoryId: Int
    let imageUrl: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case price
        case giftName = "gift_name"
        case categoryId = "category_id"
        case imageUrl = "image_url"
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.price = try container.decode(String.self, forKey: .price)
        self.giftName = try container.decode(String.self, forKey: .giftName)
        self.categoryId = try container.decode(Int.self, forKey: .categoryId)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }
}
