//
//  NSObjectProtocolExtension.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// NSObjectProtocolの拡張
extension NSObjectProtocol {

    // クラス名を返す変数"className"を返す
    static var className: String {
        return String(describing: self)
    }
}
