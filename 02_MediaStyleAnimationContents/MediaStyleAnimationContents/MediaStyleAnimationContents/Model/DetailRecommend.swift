//
//  DetailRecommend.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/05.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import SwiftyJSON

class DetailRecommend {

    // MARK: - Static Function

    // JSONから記事部分のデータ一覧から表示対象Entityの配列へ変換したものを取得する
    static func getDetailRecommendList(_ json: JSON) -> [DetailRecommendEntity] {
        let detailRecommendList = json[0]["topics"].map{
            DetailRecommendEntity($1)
        }
        return detailRecommendList
    }
}
