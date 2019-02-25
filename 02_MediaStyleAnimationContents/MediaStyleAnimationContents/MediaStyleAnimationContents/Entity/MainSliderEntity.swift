//
//  MainSliderEntity.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MainSliderEntity {

    private (set)var id: Int = 0
    private (set)var title: String = ""
    private (set)var imageUrl: URL? = nil

    // MARK: - Initializer

    init(_ json: JSON) {
        if let id = json["id"].int {
            self.id = id
        }
        if let title = json["title"].string {
            self.title = title
        }
        if let imageUrl = json["image_url"].string {
            self.imageUrl = URL(string: imageUrl)
        }
    }
}
