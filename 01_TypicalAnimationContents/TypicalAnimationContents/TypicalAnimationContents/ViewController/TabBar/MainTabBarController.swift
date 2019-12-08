//
//  MainTabBarController.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FontAwesome_swift
import TransitionableTab

final class MainTabBarController: UITabBarController {

    private let selectedTabBarAnimation: MainTabBarAnimations = .move

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMainTabBarInitialSetting()
        setupMainTabBarContents()
    }

    // タブ選択時に実行する処理
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        // MEMO: UITabBarに配置されているアイコン画像をアニメーションさせるための処理
        // 現在配置されているUITabBarからUIImageViewを取得して配列にする
        // ＜同様な動きを実現するためのライブラリ＞
        // (例1) https://github.com/eggswift/ESTabBarController

        var tabBarImageViews: [UIImageView] = []
        let targetClass: AnyClass = NSClassFromString("UITabBarButton")!
        if #available(iOS 13.0, *) {
            // MEMO: iOS13以降ではUITabBarItem内の構造が変化しているので取得位置が変わる
            tabBarImageViews = tabBar.subviews
                .filter{ $0.isKind(of: targetClass) }
                .map{ $0.subviews[1] as! UIImageView }
        } else {
            tabBarImageViews = tabBar.subviews
                .filter{ $0.isKind(of: targetClass) }
                .map{ $0.subviews.first as! UIImageView }
        }
        // アイコン画像にバウンドさせるアニメーションを付与する
        executeBounceAnimationFor(selectedImageView: tabBarImageViews[item.tag])
    }

    // MARK: - Private Function

    // UITabBarControllerの初期設定に関する調整
    private func setupMainTabBarInitialSetting() {
        
        // UITabBarControllerDelegateの宣言
        self.delegate = self

        // 初期設定として空のUIViewControllerのインスタンスを追加する
        self.viewControllers = [UIViewController(), UIViewController(), UIViewController()]
    }

    // GlobalTabBarControllerで表示したい画面に関する設定処理
    private func setupMainTabBarContents() {

        // タブの選択時・非選択時の色とアイコンのサイズを決める
        let itemSize = CGSize(width: 28.0, height: 28.0)
        let normalColor: UIColor = UIColor(code: "#bcbcbc")
        let selectedColor: UIColor = UIColor(code: "#696969")
        let tabBarItemFont = UIFont(name: "HiraKakuProN-W6", size: 10)!

        // TabBar用のAttributeを決める
        let normalAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: tabBarItemFont,
            NSAttributedString.Key.foregroundColor: normalColor
        ]
        let selectedAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: tabBarItemFont,
            NSAttributedString.Key.foregroundColor: selectedColor
        ]
        
        // TabBarに表示する画面を決める
        let _ = MainTabBarItems.allCases.enumerated().map { (index, item) in
            
            // 該当ViewControllerの設置
            guard let vc = item.getViewController() else {
                fatalError()
            }
            self.viewControllers?[index] = vc

            // 該当ViewControllerのタイトル設置
            self.viewControllers?[index].title = item.getTitle()

            // 該当ViewControllerのタブバー要素設置
            self.viewControllers?[index].tabBarItem.tag = index
            self.viewControllers?[index].tabBarItem.setTitleTextAttributes(normalAttributes, for: [])
            self.viewControllers?[index].tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
            self.viewControllers?[index].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -1.5)
            self.viewControllers?[index].tabBarItem.image = UIImage.fontAwesomeIcon(name: item.getFontAwesomeIcon(), style: .solid, textColor: normalColor, size: itemSize).withRenderingMode(.alwaysOriginal)
            self.viewControllers?[index].tabBarItem.selectedImage = UIImage.fontAwesomeIcon(name: item.getFontAwesomeIcon(), style: .solid, textColor: selectedColor, size: itemSize).withRenderingMode(.alwaysOriginal)
        }
    }

    // 該当のUIImageViewに対してバウンドするアニメーションを実行する
    // アニメーション自体は0.16秒で実行され＆割り込みを許可する
    private func executeBounceAnimationFor(selectedImageView: UIImageView) {
        UIView.animateKeyframes(withDuration: 0.16, delay: 0.0, options: [.allowUserInteraction, .autoreverse], animations: {

            // 全体のアニメーション時間の中のどの地点からアニメーションを開始するかを0.0〜1.0の間で指定する
            // 参考: iOSアプリ開発でアニメーションするなら押さえておきたい基礎
            // https://qiita.com/hachinobu/items/57d4c305c907805b4a53

            // withRelativeStartTime: 0.16*0秒後に実行する
            // relativeDuration: アニメーション時間を1.0秒とする
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: {
                selectedImageView.transform = CGAffineTransform(scaleX: 1.14, y: 1.14)
            })

            // withRelativeStartTime: 0.16*0.5秒後に実行する
            // relativeDuration: アニメーション時間を1.0秒とする
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 1.0, animations: {
                selectedImageView.transform = CGAffineTransform.identity
            })
        })
    }
}

// MARK: - TransitionableTab

// MEMO: UITabBarControllerDelegateの処理がすでにTransitionableTabプロトコルで考慮している
extension MainTabBarController: TransitionableTab {

    // アニメーションの実行秒数
    func transitionDuration() -> CFTimeInterval {
        return 0.36
    }

    // アニメーションの実行オプション
    func transitionTimingFunction() -> CAMediaTimingFunction {
        return .easeInOut
    }

    // コンテンツ切り替え時にタブのインデックス値が増加する場合に実行するアニメーションの設定
    func fromTransitionAnimation(layer: CALayer?, direction: Direction) -> CAAnimation {
        // MEMO: 戻るアニメーションを、別途定義したMainTabBarAnimationsより取得する
        return selectedTabBarAnimation.getBackAnimationWhenSelectedIndex(layer: layer, direction: direction)
    }

    // コンテンツ切り替え時にタブのインデックス値が減少する場合に実行するアニメーションの設定
    func toTransitionAnimation(layer: CALayer?, direction: Direction) -> CAAnimation {
        // MEMO: 進むアニメーションを、別途定義したMainTabBarAnimationsより取得する
        return selectedTabBarAnimation.getForwardAnimationWhenSelectedIndex(layer: layer, direction: direction)
    }

    // コンテンツ切り替え時に実行される処理
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return animateTransition(tabBarController, shouldSelect: viewController)
    }
}
