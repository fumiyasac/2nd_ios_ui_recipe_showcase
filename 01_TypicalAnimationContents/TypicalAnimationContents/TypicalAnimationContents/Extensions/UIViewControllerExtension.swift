//
//  UIViewControllerExtension.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// UIViewControllerの拡張
extension UIViewController {

    // この画面のナビゲーションバーを設定するメソッド
    func setupNavigationBarTitle(_ title: String) {

        // NavigationControllerのフォントに関するデザイン調整を行う
        var attributes = [NSAttributedString.Key : Any]()
        attributes[NSAttributedString.Key.font] = UIFont(name: "HiraKakuProN-W6", size: 14.0)
        attributes[NSAttributedString.Key.foregroundColor] = UIColor(code: "#333333")

        // NavigationControllerの配色に関するデザイン調整を行う
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.barTintColor = UIColor(code: "#ffffff")
        self.navigationController!.navigationBar.titleTextAttributes = attributes

        // タイトルを入れる
        self.navigationItem.title = title

        // ラージタイトルの表示設定に関する設定やデザイン調整を行う
        // 下記「stackoverflow」に掲載されていたコードを参考に実装しています。
        // http://bit.ly/2TXCbd7
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true

        // MEMO: iOS13以降ではラージタイトル表示時の属性テキストの設定方法が若干変わる点に注意する
        // https://qiita.com/MilanistaDev/items/6181495e8504612ec053
        var largeAttributes = [NSAttributedString.Key : Any]()
        largeAttributes[NSAttributedString.Key.font] = UIFont(name: "HiraKakuProN-W6", size: 26.0)
        largeAttributes[NSAttributedString.Key.foregroundColor] = UIColor(code: "#333333")

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor(code: "#ffffff")
            appearance.largeTitleTextAttributes = largeAttributes
            appearance.titleTextAttributes = attributes
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.navigationController?.navigationBar.standardAppearance = appearance
        } else {
            self.navigationController?.navigationBar.largeTitleTextAttributes = largeAttributes
        }
    }

    // 戻るボタンの「戻る」テキストを削除した状態にするメソッド
    func removeBackButtonText() {
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor(code: "#333333")
        self.navigationItem.backBarButtonItem = backButtonItem
    }
}
