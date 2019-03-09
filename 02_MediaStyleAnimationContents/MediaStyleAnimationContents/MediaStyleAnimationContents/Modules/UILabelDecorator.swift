//
//  UILabelDecorator.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/08.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

final class UILabelDecorator {

    // MARK: - Static Function

    // 該当のUILabelに付与する属性を設定する
    static func getLabelAttributesBy(keys: (lineSpacing: CGFloat, font: UIFont, foregroundColor: UIColor)) -> [NSAttributedString.Key : Any] {

        // 行間に関する設定をする
        // MEMO: lineBreakModeの指定しないとはみ出た場合の「...」が出なくなる
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = keys.lineSpacing
        paragraphStyle.lineBreakMode = .byTruncatingTail

        // 上記で定義した行間・フォント・色を属性値として設定する
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        attributes[NSAttributedString.Key.font] = keys.font
        attributes[NSAttributedString.Key.foregroundColor] = keys.foregroundColor

        return attributes
    }

    // 該当のUILabelに付与する属性を設定する
    static func getHashTagsAttributesBy(minimumLineHeight: CGFloat) -> [NSAttributedString.Key : Any] {

        // 最小の行の高さに関する設定をする
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = minimumLineHeight

        // 上記で定義した最小の行の高さ・色を属性値として設定する
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle

        return attributes
    }
}
