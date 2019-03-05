//
//  MainSlider.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import SwiftyJSON

class MainSlider {

    // MARK: - Static Function

    // JSONから記事部分のデータ一覧から表示対象Entityの配列へ変換したものを取得する
    static func getMainSliderList(_ json: JSON) -> [MainSliderEntity] {
        let mainSliderList = json[0]["topics"].map{
            MainSliderEntity($1)
        }
        return mainSliderList
    }
}
