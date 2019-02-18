//
//  PhotoGalleryModel.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MEMO: こちらのデータはJSONから生成する
struct PhotoGalleryModel: Decodable {

    let id: Int
    let title: String
    let summary: String
    let image: UIImage

    private enum Keys: String, CodingKey {
        case id
        case title
        case summary
        case imageName = "image_name"
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id      = try container.decode(Int.self, forKey: .id)
        self.title   = try container.decode(String.self, forKey: .title)
        self.summary = try container.decode(String.self, forKey: .summary)

        let imageName = try container.decode(String.self, forKey: .imageName)
        self.image = UIImage(named: imageName)!
    }
}
