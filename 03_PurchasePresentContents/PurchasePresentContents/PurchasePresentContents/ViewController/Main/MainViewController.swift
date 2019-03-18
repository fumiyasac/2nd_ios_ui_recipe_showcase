//
//  MainViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/02/10.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import PinterestSegment


final class MainViewController: UIViewController {

    @IBOutlet weak private var lineupSegmentControl: PinterestSegment!

    // ページングして表示させるViewControllerを保持する配列
    private var targetViewControllerLists: [UIViewController] = []

    // ContainerViewにEmbedしたUIPageViewControllerのインスタンスを保持する
    private var pageViewController: UIPageViewController?

    // 現在UIPageViewControllerで表示しているViewControllerのインデックス番号
    private var currentIndex: Int = 0

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle("PRESENT SHOP")
        setupLineupSegmentControl()
        setupPageViewController()
    }

    // MARK: - Private Function

    private func setupLineupSegmentControl() {

        // PinterestSegmentのスタイルを設定する
        var segmentStyle = PinterestSegmentStyle()
        segmentStyle.indicatorColor = UIColor(code: "#ffae00")
        segmentStyle.titlePendingHorizontal = 16
        segmentStyle.titlePendingVertical = 16
        segmentStyle.titleFont = UIFont(name: "HiraKakuProN-W6", size: 13.0)!
        segmentStyle.normalTitleColor = .lightGray
        segmentStyle.selectedTitleColor = .white
        lineupSegmentControl.style = segmentStyle

        // PinterestSegmentのタイトルを設定する
        lineupSegmentControl.titles = MainSectionType.allCases.map{
            $0.getTitle()
        }

        // PinterestSegmentのタップ時のアクションを設定する
        lineupSegmentControl.valueChange = { targetIndex in

            // MEMO: 現在のIndex値と切り替え対象のIndex値の差分で動きを決定する
            let diff = self.currentIndex - targetIndex
            if diff > 0 {
                self.moveToPageViewControllerFor(targetIndex: targetIndex, targetDirection: .reverse)
            } else if diff < 0 {
                self.moveToPageViewControllerFor(targetIndex: targetIndex, targetDirection: .forward)
            }
            self.currentIndex = targetIndex
        }
    }

    // UIPageViewControllerの設定
    private func setupPageViewController() {

        // UIPageViewControllerで表示したいViewControllerの一覧を取得する
        let _ = MainSectionType.allCases.map{
            let targetViewController = $0.getViewController()
            targetViewController.view.tag = $0.rawValue
            targetViewControllerLists.append(targetViewController)
        }

        // ContainerViewと接続しているUIPageViewControllerを取得する
        for childViewController in children {
            if let targetPageViewController = childViewController as? UIPageViewController {
                pageViewController = targetPageViewController
            }
        }

        // UIPageViewControllerにおける初期設定をする
        if let targetPageViewController = pageViewController {

            // MEMO: Storyboardを利用する場合はTransitionStyleはInterfaceBuilderで設定する

            // UIPageViewControllerDelegate & UIPageViewControllerDataSourceの宣言
            targetPageViewController.delegate = self
            targetPageViewController.dataSource = self

            // 最初に表示する画面として配列の先頭のViewControllerを設定する
            targetPageViewController.setViewControllers([targetViewControllerLists[0]], direction: .forward, animated: false, completion: nil)
        }
    }

    // 該当のIndex値と動かす方向に合わせて表示対象のUIViewControllerを表示させる
    private func moveToPageViewControllerFor(targetIndex: Int, targetDirection: UIPageViewController.NavigationDirection) {
        if let targetPageViewController = pageViewController {
            targetPageViewController.setViewControllers([targetViewControllerLists[targetIndex]], direction: targetDirection, animated: true, completion: nil)
        }
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension MainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    // スワイプアニメーションでページが動いたタイミングで実行される
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        // スワイプアニメーションが完了していない場合は以降の処理を実行しない
        if !completed {
            return
        }

        // ここから先はUIPageViewControllerのスワイプアニメーション完了時に発動する
        if let targetViewControllers = pageViewController.viewControllers {
            if let targetViewController = targetViewControllers.last {

                // 受け取ったインデックス値を元にコンテンツ表示を更新する
                currentIndex = targetViewController.view.tag
                lineupSegmentControl.setSelectIndex(index: currentIndex, animated: true)
            }
        }
    }

    // 逆方向にページ送りしたタイミングで実行される
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        // インデックスを取得してその値に応じてコンテンツを移動する
        guard let index = targetViewControllerLists.index(of: viewController) else {
            return nil
        }

        if index <= 0 {
            return nil
        }

        return targetViewControllerLists[index - 1]
    }

    // 順方向にページ送りしたタイミングで実行される
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        // インデックスを取得してその値に応じてコンテンツを移動する
        guard let index = targetViewControllerLists.index(of: viewController) else {
            return nil
        }

        if index >= targetViewControllerLists.count - 1 {
            return nil
        }
        
        return targetViewControllerLists[index + 1]
    }
}
