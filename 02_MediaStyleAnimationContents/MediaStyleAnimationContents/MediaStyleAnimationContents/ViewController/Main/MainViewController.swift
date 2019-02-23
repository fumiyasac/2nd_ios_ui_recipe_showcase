//
//  ViewController.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/10.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import Floaty
import FontAwesome_swift

final class MainViewController: UIViewController {

    @IBOutlet weak private var mainMenuButton: Floaty!
    @IBOutlet weak private var mainArticlesContainerViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle("旅行で出会った風景達")
        removeBackButtonText()
        setupMainMenuButton()
    }

    // MARK: - Private Function

    private func setupMainMenuButton() {

        // メニューボタンのデザインを設定する
        mainMenuButton.buttonColor = UIColor(code: "#cf504c")
        mainMenuButton.plusColor = .white
        mainMenuButton.overlayColor = UIColor.black.withAlphaComponent(0.67)
        mainMenuButton.sticky = true

        // MainMenuListsの定義からボタンアイテムを配置する
        let _ = MainMenuLists.allCases.map {

            // ボタンアイテムを設定する
            let mainManuCase = $0
            let item = FloatyItem()

            // ボタンアイテムのタップ時挙動を設定する
            item.handler = { _ in
                /*
                let sb = UIStoryboard(name: menuButtonCase.getStoryboardName(), bundle: nil)
                if let vc = sb.instantiateInitialViewController() {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                */
            }

            // ボタンアイテムのデザインを設定する
            decorarteMainMenuButton(item: item, menuType: mainManuCase)

            // ボタンアイテムを配置する
            mainMenuButton.addItem(item: item)
        }
    }
    
    private func decorarteMainMenuButton(item: FloatyItem, menuType: MainMenuLists) {

        // アイコンの配置位置とサイズを設定する
        let itemOrigin = CGPoint(x: 7.0, y: 7.0)
        let itemSize = CGSize(width: 28.0, height: 28.0)
        
        // タイトル文字列を設定する
        /*
        item.title = menuType.getButtonName()
        */
        
        // ボタンの色を設定する
        item.buttonColor = UIColor(code: "#333333", alpha: 0.5)
        
        // 表示ラベルのフォントを設定する
        item.titleLabel.textAlignment = .right
        item.titleLabel.font = UIFont(name: "HiraKakuProN-W6", size: 14.0)

        // ボタン右のアイコン表示を設定する
        item.iconImageView.tintColor = .white
        item.iconImageView.frame = CGRect(origin: itemOrigin, size: itemSize)
        /*
        item.iconImageView.image = UIImage.fontAwesomeIcon(name: type.getFontAwesomeIcon(), style: .solid, textColor: .white, size: itemSize)
        */
    }
}
