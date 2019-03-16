//
//  StoryboardInstantiatable.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// StoryboardからViewControllerを生成するProtocol
// 参考：http://blog.sgr-ksmt.org/2016/05/05/storyboard_instantiatable/

public protocol StoryboardInstantiatable {

    // インスタンス化の際に必要な変数の定義
    static var storyboardName: String { get }
    static var viewControllerIdentifier: String? { get }
    static var bundle: Bundle? { get }
}

// プロトコル「StoryboardInstantiatable」の実装定義 ※UIViewControllerとそのサブクラスになるように定義
extension StoryboardInstantiatable where Self: UIViewController {

    // Storyboard名のプロパティ
    static var storyboardName: String {
        return String(describing: self)
    }

    // ViewControllerIdentifier名のプロパティ(特に必要がなければ設定しなくてもよい)
    static var viewControllerIdentifier: String? {
        return nil
    }

    // Bundle名のプロパティ(特に必要がなければ設定しなくてもよい)
    static var bundle: Bundle? {
        return nil
    }
    
    // Storyboardからインスタンス化するメソッド
    static func instantiate() -> Self {

        // StoryboardからViewControllerのインスタンス化をする（定義したプロパティの情報を元に行う）
        let loadViewController = { () -> UIViewController? in
            let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
            if let viewControllerIdentifier = viewControllerIdentifier {
                return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
            } else {
                return storyboard.instantiateInitialViewController()
            }
        }

        // Storyboardから作成できない場合は意図的にクラッシュさせる
        guard let viewController = loadViewController() as? Self else {
            fatalError([
                "Failed to load viewcontroller from storyboard.",
                "storyboard: \(storyboardName), viewControllerID: \(String(describing: viewControllerIdentifier)), bundle: \(String(describing: bundle))"
                ].joined(separator: " ")
            )
        }
        return viewController
    }
}

