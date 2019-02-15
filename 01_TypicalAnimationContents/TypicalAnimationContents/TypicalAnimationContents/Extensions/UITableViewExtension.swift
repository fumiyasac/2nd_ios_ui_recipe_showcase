//
//  UITableViewExtension.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// UITableViewCellの拡張
extension UITableViewCell {

    // 独自に定義したセルのクラス名を返す
    static var identifier: String {
        return className
    }
}

// UITableViewの拡張
extension UITableView {

    // 作成した独自のカスタムセルを初期化するメソッド
    func registerCustomCell<T: UITableViewCell>(_ cellType: T.Type) {
        register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }

    // 作成した独自のカスタムセルをインスタンス化するメソッド
    func dequeueReusableCustomCell<T: UITableViewCell>(with cellType: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier) as! T
    }
}
