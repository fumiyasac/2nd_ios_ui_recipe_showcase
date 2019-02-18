//
//  NewsViewController.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class NewsViewController: UIViewController {

    private var targetNews: [NewsModel] = [] {
        didSet {
            self.newsTableView.reloadData()
        }
    }
    private var preseter: NewsPresenter!

    @IBOutlet weak private var newsTableView: UITableView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(MainTabBarItems.news.getTitle())
        setupNewsTableView()
        setupNewsPresenter()
    }

    // MARK: - Private Function

    private func setupNewsTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 200.0
        newsTableView.registerCustomCell(NewsTableViewCell.self)
    }

    private func setupNewsPresenter() {
        preseter = NewsPresenter()
        preseter.delegate = self
        preseter.getNewsList()
    }

    // UITableViewCell内のオフセット値を再計算して視差効果をつける
    private func setCellImageOffset(_ cell: NewsTableViewCell, indexPath: IndexPath) {

        // cellの位置関係から動かす制約の値を決定する
        let cellFrame = newsTableView.rectForRow(at: indexPath)
        let cellFrameInTable = newsTableView.convert(cellFrame, to: newsTableView.superview)
        let cellOffset = cellFrameInTable.origin.y + cellFrameInTable.size.height
        let tableHeight = newsTableView.bounds.size.height + cellFrameInTable.size.height
        let cellOffsetFactor = cellOffset / tableHeight

        // 画面に表示されているセルの画像のオフセット値を変更する
        cell.setImageViewOffset(cellOffsetFactor)
    }

    // UITableViewCellが表示されるタイミングにフェードインのアニメーションをつける
    private func setCellFadeInAnimation(_ cell: NewsTableViewCell) {

        /**
         * CoreAnimationを利用したアニメーションをセルの表示時に付与する（拡大とアルファの重ねがけ）
         *
         * 参考:【iOS Swift入門 #185】Core Animationでアニメーションの加速・減速をする
         * http://swift-studying.com/blog/swift/?p=1162
         */

        // アニメーションの作成
        let groupAnimation = CAAnimationGroup()
        groupAnimation.fillMode = CAMediaTimingFillMode.backwards
        groupAnimation.duration = 0.36
        groupAnimation.beginTime = CACurrentMediaTime() + 0.08
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)

        // 透過を変更するアニメーション
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.0
        opacityAnimation.toValue = 1.0

        // 作成した個別のアニメーションをグループ化
        groupAnimation.animations = [opacityAnimation]

        // セルのLayerにアニメーションを追加
        cell.layer.add(groupAnimation, forKey: nil)

        // アニメーション終了後は元のサイズになるようにする
        cell.layer.transform = CATransform3DIdentity
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: NewsTableViewCell.self)
        cell.setCell(targetNews[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {

    //セルを表示しようとする時に実行される処理
    /**
     * willDisplay(UITableViewDelegateのメソッド)に関して
     * 参考: Cocoa API解説(macOS/iOS) tableView:willDisplayCell:forRowAtIndexPath:
     * https://goo.gl/Ykp30Q
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        // セル内の画像のオフセット値を変更 & フェードインのCoreAnimationを適用する
        let targetCell = cell as! NewsTableViewCell
        setCellImageOffset(targetCell, indexPath: indexPath)
        setCellFadeInAnimation(targetCell)
    }
}

// MARK: - UIScrollViewDelegate

extension NewsViewController: UIScrollViewDelegate {

    // スクロールが検知された時に実行される処理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        // 画面に表示されているセルの画像のオフセット値を変更する
        if let indexPaths = newsTableView.indexPathsForVisibleRows {
            let _ = indexPaths.map {
                let targetCell = newsTableView.cellForRow(at: $0) as! NewsTableViewCell
                setCellImageOffset(targetCell, indexPath: $0)
            }
        }
    }
}

// MARK: - PhotoGalleryPresenterDelegate

extension NewsViewController: NewsPresenterDelegate {

    // MEMO: 値がセットされたタイミングで更新処理が実行される
    func setNewsToScreen(_ news: [NewsModel]) {
        targetNews = news
    }
}

