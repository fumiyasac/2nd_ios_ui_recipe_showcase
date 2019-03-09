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

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle("旅行で出会った風景達")
        removeBackButtonText()
        setupMainMenuButton()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        applyChildViewControllerDelegatesFor(targetSegue: segue)
    }

    // MARK: - Private Function

    // ContainerViewで表示しているViewControllerのプロトコルを適合する
    private func applyChildViewControllerDelegatesFor(targetSegue: UIStoryboardSegue) {

        // Storyboardの名前からViewControllerのインスタンスを取得してprotocolを適用する
        if targetSegue.identifier == "ConnectMainArticleContainer" {
            let vc = targetSegue.destination as! MainArticleViewController
            vc.delegate = self
        }

        // MEMO: このViewControllerに配置している他のContainerViewで表示しているものProtocolを適用するための準備
        // 手順1. 対象ContainerViewの「EmbedSegue」部分にInterfaceBuilderでを利用して任意の名前をつける
        // 手順2. prepareメソッド内でidentifierプロパティの値とつけた名前が一致するかを判定する
        // 手順3. 一致する場合はdestinationプロパティの値を該当のViewControllerへダウンキャストしてインスタンスを取得する
    }

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
                let sb = UIStoryboard(name: mainManuCase.getStoryboardName(), bundle: nil)
                if let vc = sb.instantiateInitialViewController() {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }

            // ボタンアイテムのデザインを設定する
            decorarteMainMenuButton(item: item, mainMenu: mainManuCase)

            // ボタンアイテムを配置する
            mainMenuButton.addItem(item: item)
        }
    }
    
    private func decorarteMainMenuButton(item: FloatyItem, mainMenu: MainMenuLists) {

        // アイコンの配置位置とサイズを設定する
        let itemOrigin = CGPoint(x: 7.0, y: 7.0)
        let itemSize = CGSize(width: 28.0, height: 28.0)
        
        // タイトル文字列を設定する
        item.title = mainMenu.getTitle()

        // ボタンの色を設定する
        item.buttonColor = UIColor(code: "#333333", alpha: 0.5)

        // 表示ラベルのフォントを設定する
        item.titleLabel.textAlignment = .right
        item.titleLabel.font = UIFont(name: "HiraKakuProN-W6", size: 14.0)

        // ボタン右のアイコン表示を設定する
        item.iconImageView.tintColor = .white
        item.iconImageView.frame = CGRect(origin: itemOrigin, size: itemSize)
        item.iconImageView.image = UIImage.fontAwesomeIcon(name: mainMenu.getIcon(), style: .solid, textColor: .white, size: itemSize)
    }
}

// MARK: - MainArticleViewControllerDelegate

extension MainViewController: MainArticleViewControllerDelegate {

    // 記事一覧を表示しているContainerViewの高さ制約を更新する
    func updateContainerViewHeight(_ height: CGFloat) {
        mainArticlesContainerViewHeightConstraint.constant = height
    }

    // 該当のデータ(MainArticleEntity)を遷移先へ引き渡して進む
    func sendTargetEntity(_ entity: MainArticleEntity) {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! DetailViewController
        vc.setMainArticleEntityFromPresentedViewController(entity)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
