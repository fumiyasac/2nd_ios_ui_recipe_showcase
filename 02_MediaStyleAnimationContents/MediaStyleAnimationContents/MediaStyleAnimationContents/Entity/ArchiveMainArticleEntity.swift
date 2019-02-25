//
//  ArchiveMainArticleEntity.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import RealmSwift

// MEMO: 一時的にアーカイブをするためにRealmSwiftのObjectクラスを継承している
// → 詳細はRealmでのドキュメントを参考にして頂ければと思います。

class ArchiveMainArticleEntity: Object {

    @objc dynamic var mainArticleId = 0
    @objc dynamic var category = 0
    @objc dynamic var title = ""
    @objc dynamic var thumbnailUrl = ""
    @objc dynamic var createdAt = Date()

    // MARK: - Override

    override class func primaryKey() -> String? {
        return "mainArticleId"
    }
}
