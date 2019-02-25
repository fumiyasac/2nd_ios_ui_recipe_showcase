//
//  ArchiveMainArticle.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import RealmSwift

class ArchiveMainArticle {

    // MARK: - Static Function

    static func isRegistered(_ mainArticleEntity: MainArticleEntity) -> Bool {
        if let _ = findBy(id: mainArticleEntity.id) {
            return true
        }
        return false
    }

    // MARK: - Private Function

    private static func findBy(id: Int) -> ArchiveMainArticleEntity? {
        do {
            let realm = try Realm()
            if let archive = realm.objects(ArchiveMainArticleEntity.self).filter("mainArticleId == %@", id).first {
                return archive
            }
        } catch {}
        return nil
    }
}
