//
//  ProfileLists.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/02.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

enum ProfileLists: CaseIterable {

    case twitter, facebook, github, slideshare, medium, note

    // MARK: - Function

    func getTitle() -> String {
        switch self {
        case .twitter:
            return "Twitter"
        case .facebook:
            return "Facebook"
        case .github:
            return "Github"
        case .slideshare:
            return "SlideShare"
        case .medium:
            return "Medium"
        case .note:
            return "note"
        }
    }

    func getDescription() -> String {
        switch self {
        case .twitter:
            return "日々の細かなことや勉強会のアウトプット用ノートを掲載しています。"
        case .facebook:
            return "最近は勉強会での登壇資料やオフィシャルでの告知を掲載しています。"
        case .github:
            return "時間があればサンプルを開発やUI検証・サーバーサイドの設計をしてます。"
        case .slideshare:
            return "大体月数回ほどのペースで主にiOSアプリ開発に関する登壇をしています。"
        case .medium:
            return "こちらは「サンプル開発のまかないアイデア」として不定期で更新中です。"
        case .note:
            return "こちらは「コードを伴わない文章でのアウトプット」をメインに行っています。"
        }
    }

    func getColor() -> UIColor {
        switch self {
        case .twitter:
            return UIColor(code: "#00aced")
        case .facebook:
            return UIColor(code: "#3b5998")
        case .github:
            return UIColor(code: "#333333")
        case .slideshare:
            return UIColor(code: "#0077b5")
        case .medium:
            return UIColor(code: "#00ab6c")
        case .note:
            return UIColor(code: "#249f80")
        }
    }

    func getLink() -> URL? {
        switch self {
        case .twitter:
            return URL(string: "https://twitter.com/fumiyasac")
        case .facebook:
            return URL(string: "https://www.facebook.com/fumiya.sakai.37")
        case .github:
            return URL(string: "https://github.com/fumiyasac")
        case .slideshare:
            return URL(string: "https://www.slideshare.net/fumiyasakai37")
        case .medium:
            return URL(string: "https://medium.com/@fumiyasakai/")
        case .note:
            return URL(string: "https://note.mu/fumiyasac")
        }
    }

    func getIcon() -> FontAwesome {
        switch self {
        case .twitter:
            return .twitter
        case .facebook:
            return .facebook
        case .github:
            return .github
        case .slideshare:
            return .slidersH
        case .medium:
            return .medium
        case .note:
            return .file
        }
    }
}
