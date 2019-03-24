//
//  MainInformationViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class MainInformationViewController: UIViewController {

    @IBOutlet weak private var mainInformationScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mainInformationScrollView.delegate = self
    }
}

// MARK: - UIScrollViewDelegate

extension MainInformationViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        // MEMO: UIScrollViewでのスクロールが実行された際にコンテンツが一番上にある状態の場合の考慮をする
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = 0
            scrollView.bounces = false
        } else {
            scrollView.bounces = true
        }
    }
}

// MARK: - StoryboardInstantiatable

extension MainInformationViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "MainInformation"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
