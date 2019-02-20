//
//  TopicsViewController.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/10.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class TopicsViewController: UIViewController {

    private var targetTopics: [TopicsModel] = [] {
        didSet {
            self.topicsCollectionView.reloadData()
        }
    }
    private var preseter: TopicsPresenter!

    @IBOutlet weak var topicsCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(MainTabBarItems.topics.getTitle())
        setupTopicsCollectionView()
        setupTopicsPresenter()
    }

    // MARK: - Private Function

    private func setupTopicsCollectionView() {

        // MEMO: collectionViewLayoutプロパティにセットする値(UICollectionViewに関する調整値)を定義する
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = TopicsCardView.viewSize
        layout.minimumLineSpacing = TopicsCardView.cardMargin
        layout.minimumInteritemSpacing = TopicsCardView.cardMargin
        layout.sectionInset = UIEdgeInsets(top: TopicsCardView.cardMargin, left: TopicsCardView.cardMargin, bottom: TopicsCardView.cardMargin, right: TopicsCardView.cardMargin)
        layout.scrollDirection = .vertical
        topicsCollectionView.collectionViewLayout = layout

        // MEMO: UICollectionViewそのものに関する設定を定義する
        topicsCollectionView.registerCustomCell(TopicsCollectionViewCell.self)
        topicsCollectionView.dataSource = self
        topicsCollectionView.scrollsToTop = false
    }

    private func setupTopicsPresenter() {
        preseter = TopicsPresenter()
        preseter.delegate = self
        preseter.getTopicsList()
    }
}

// MARK: - UICollectionViewDataSource

extension TopicsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return targetTopics.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: TopicsCollectionViewCell.self, indexPath: indexPath)
        cell.setCell(targetTopics[indexPath.row])
        return cell
    }
}

// MARK: - TopicsPresenterDelegate

extension TopicsViewController: TopicsPresenterDelegate {

    // MEMO: 値がセットされたタイミングで更新処理が実行される
    func setTopicsToScreen(_ topics: [TopicsModel]) {
        targetTopics = topics
    }
}

