//
//  DetailGiftViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FloatingPanel

final class DetailGiftViewController: UIViewController {

    private let floatingPanel: FloatingPanelController = FloatingPanelController()

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFloatingPanel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // セミモーダルビューを非表示にする
        floatingPanel.removePanelFromParent(animated: true)
    }

    // MARK: - Private Function

    private func setupFloatingPanel() {

        // セミモーダルビューで表示する画面をFloatingPanelControllerへセットする
        let detailCommentViewController = DetailCommentViewController.instantiate()
        floatingPanel.set(contentViewController: detailCommentViewController)

        // セミモーダルビューを表示する
        floatingPanel.addPanel(toParent: self, belowView: nil, animated: true)
    }
}

// MARK: - StoryboardInstantiatable

extension DetailGiftViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Detail"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return DetailGiftViewController.className
    }
}
