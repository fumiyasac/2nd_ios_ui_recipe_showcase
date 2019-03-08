//
//  MainArticleEntity.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MainArticleEntity {

    private (set)var id: Int = 0
    private (set)var category: Int = 0
    private (set)var title: String = ""
    private (set)var summary: String = ""
    private (set)var thumbnailUrl: URL? = nil
    private (set)var publishDate: String = ""
    private (set)var totalViews: String = ""

    // MARK: - Initializer

    init(_ json: JSON) {
        if let id = json["id"].int {
            self.id = id
        }
        if let category = json["category"].int {
            self.category = category
        }
        if let title = json["title"].string {
            self.title = title
        }
        if let summary = json["summary"].string {
            self.summary = summary
        }
        if let thumbnailUrl = json["image_url"].string {
            self.thumbnailUrl = URL(string: thumbnailUrl)
        }
        if let publishDate = json["publish_date"].string {
            self.publishDate = publishDate
        }
        if let totalViews = json["total_views"].string {
            self.totalViews = totalViews
        }
    }
}
