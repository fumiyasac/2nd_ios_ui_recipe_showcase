//
//  MainSliderViewController.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FSPagerView
import AlamofireImage

final class MainSliderViewController: UIViewController {

    // 表示内容を一時的に格納するための変数
    private var mainSliderLists: [MainSliderEntity] = [] {
        didSet {
            self.mainSliderView.reloadData()
        }
    }

    // ViewModelの初期化に必要な要素の定義
    private let notificationCenter = NotificationCenter()
    private let api = ArticleAPIManager.shared

    // ViewModelの初期化
    private lazy var viewModel = MainSliderViewModel(notificationCenter: notificationCenter, api: api)

    @IBOutlet weak private var mainSliderView: FSPagerView!
    @IBOutlet weak private var mainSliderErrorView: MainSliderErrorView!
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotificationsForDataBinding()
        setupSliderView()
        setupSliderErrorView()
    }

    // MARK: - Private Function

    // 写真データ取得成功の通知を受信した際に実行される処理
    @objc private func receiveSuccessNotificaton(notification: Notification) {

        // View描画に関わる変更を反映する
        mainSliderView.isHidden = false
        mainSliderErrorView.isHidden = true

        // データ表示に関わる変更を反映する
        mainSliderLists = viewModel.targetMainSliderLists
    }

    // 写真データ取得失敗の通知を受信した際に実行される処理
    @objc private func receiveFailureNotificaton(notification: Notification) {

        // View描画に関わる変更を反映する
        mainSliderView.isHidden = true
        mainSliderErrorView.isHidden = false
    }

    // DataBindingを実行するための通知に関する初期設定をする
    private func setupNotificationsForDataBinding() {

        // MEMO: NotificationCenterを利用してViewModel側の変更を取得できるようにしている
        // 書籍「iOS設計パターン入門 第6章 MVVM」で紹介されていたコードを参考に構築しました。
        notificationCenter.addObserver(
            self,
            selector: #selector(self.receiveSuccessNotificaton),
            name: viewModel.successFetchMainSlider,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(self.receiveFailureNotificaton),
            name: viewModel.failureFetchMainSlider,
            object: nil
        )
        viewModel.fetchMainSlider()
    }

    // FSPagerViewの初期設定をする
    private func setupSliderView() {
        mainSliderView.delegate = self
        mainSliderView.dataSource = self
        let imageWidth: CGFloat = UIScreen.main.bounds.width * 5 / 6
        let imageHeight: CGFloat = 150.0
        mainSliderView.itemSize = CGSize(width: imageWidth, height: imageHeight)
        mainSliderView.isInfinite = true
        mainSliderView.interitemSpacing = 16
        mainSliderView.transformer = FSPagerViewTransformer(type: .overlap)

        // MEMO: あらかじめライブラリで用意されているセルを利用する
        mainSliderView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    // エラー発生時に表示するViewの初期設定をする
    private func setupSliderErrorView() {
        mainSliderErrorView.requestSliderButtonAction = {
            self.viewModel.fetchMainSlider()
        }
    }
}

// MARK: - FSPagerViewDataSource, FSPagerViewDelegate

extension MainSliderViewController: FSPagerViewDataSource, FSPagerViewDelegate {

    // MEMO: UICollectionViewの配置対象のセクションの個数を設定する部分に相当
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return mainSliderLists.count
    }

    // MEMO: UICollectionViewの配置対象のセクションに配置するセルの個数を設定する部分に相当する
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {

        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)

        let mainSlider = mainSliderLists[index]
        if let imageUrl = mainSlider.imageUrl {
            cell.imageView?.af_setImage(withURL: imageUrl)
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
        }
        cell.textLabel?.text = mainSlider.title
        cell.textLabel?.font = UIFont(name: "HiraKakuProN-W6", size: 12.0)
        cell.contentView.layer.shadowOpacity = 0.4
        cell.contentView.layer.opacity = 0.86
        cell.backgroundColor = UIColor(code: "#eeeeee")

        return cell
    }

    // MEMO: UICollectionViewの配置対象のセクション押下時の処理を設定する部分に相当する
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
}
