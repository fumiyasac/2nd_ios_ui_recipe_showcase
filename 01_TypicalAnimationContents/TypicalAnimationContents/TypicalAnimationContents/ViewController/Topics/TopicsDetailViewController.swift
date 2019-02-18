//
//  TopicsDetailViewController.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

// MEMO: 背景用Viewとカード状ViewのAutoLayoutはSafeAreaではなくSuperviewへ付与
// → TopicsCardViewのAutoLayoutも同様の考慮をしておく

final class TopicsDetailViewController: UIViewController {

    @IBOutlet weak var topicsDetailCardView: TopicsCardView!
    @IBOutlet weak private var topicsDetailBackgroundView: UIView!
    @IBOutlet weak private var topicCardHeightConstraint: NSLayoutConstraint!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTopicsDetailCardView()
    }

    // MARK: - Function

    func setTopicsDetailViewLayout(presenting: Bool) {
        // 配置するカード状のViewを調節する
        let state: TopicsCardView.LayoutState = presenting ? .expanded : .collapsed
        topicsDetailCardView.applyLayoutSettings(layoutState: state)

        // 背景のViewに対して角丸を付与する
        topicsDetailBackgroundView.layer.cornerRadius = state.cornerRadius
    }

    // MARK: - Private Function

    private func setupTopicsDetailCardView() {
        topicsDetailCardView.delegate = self
        setTopicsDetailViewLayout(presenting: false)
        topicCardHeightConstraint.constant = TopicsCardView.viewSize.height
    }
}

// MARK: - TopicsCardViewDelegate

extension TopicsDetailViewController: TopicsCardViewDelegate {
    func closeTopicsCard() {
        self.dismiss(animated: true, completion: nil)
    }
}
