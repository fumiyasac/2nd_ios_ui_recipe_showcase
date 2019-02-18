//
//  TopicsViewController.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/10.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import EasyTransitions

final class TopicsViewController: UIViewController {

    // EasyTransitionsで拡張されたModalTransitionDelegate
    private var modalTransitionDelegate = ModalTransitionDelegate()

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
        
        // MEMO: ここはただのModalで表現し、UICollectionViewのHeaderをヘッダー代わりに利用する
        topicsCollectionView.registerCustomReusableHeaderView(TopicsHeaderReusableView.self)
        topicsCollectionView.registerCustomCell(TopicsCollectionViewCell.self)
        topicsCollectionView.dataSource = self
        topicsCollectionView.delegate = self
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

    // 配置対象のセクション配置するセル要素タップ時の振る舞いを設定する
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 表示先の画面要素を取得する
        let sb = UIStoryboard(name: "TopicsDetail", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! TopicsDetailViewController
        
        // 選択したindexPathに該当するセル要素を取得してとUICollectionViewを基準とした表示位置を取得する
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        let cellFrame = view.convert(cell.frame, from: collectionView)
        
        // ライブラリ「EasyTransitions」で定義されているAppStoreAnimatorクラスを初期化しアニメーションに関する設定をする
        let appStoreAnimator = AppStoreAnimator(initialFrame: cellFrame)
        appStoreAnimator.onReady = {
            cell.isHidden = true
        }
        appStoreAnimator.onDismissed = {
            cell.isHidden = false
        }

        let targetTopic = targetTopics[indexPath.row]
        appStoreAnimator.auxAnimation = {
            vc.setTopicsDetailViewLayout(presenting: $0)
            vc.topicsDetailCardView.setViewData(targetTopic)
        }

        // 画面遷移時に適用するmodalTransitionDelegateクラスの設定を行う
        /**
         * ポイント:
         * (1)Modalでの画面遷移時に適用するカスタムトランジションと遷移先のViewControllerとの接合を行う
         * (2)遷移先の動作対象となるView要素と遷移元で配置したUICollectionViewのセルに配置したView要素は同じものとする
         */
        modalTransitionDelegate.set(animator: appStoreAnimator, for: .present)
        modalTransitionDelegate.set(animator: appStoreAnimator, for: .dismiss)
        modalTransitionDelegate.wire(
            viewController: vc,
            with: .regular(.fromTop),
            navigationAction: {
                vc.dismiss(animated: true, completion: nil)
            }
        )

        // ライブラリ「EasyTransitions」のカスタムトランジションを画面遷移タイミングで適用する
        vc.transitioningDelegate = modalTransitionDelegate
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TopicsViewController: UICollectionViewDelegateFlowLayout {

    // 配置するUICollectionReusableViewのサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        if section == 0 {
            return TopicsHeaderReusableView.viewSize
        } else {
            return CGSize.zero
        }
    }

    // 配置するUICollectionReusableViewの設定する
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if indexPath.section == 0 && kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableCustomHeaderView(with: TopicsHeaderReusableView.self, indexPath: indexPath)
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}

// MARK: - TopicsPresenterDelegate

extension TopicsViewController: TopicsPresenterDelegate {

    // MEMO: 値がセットされたタイミングで更新処理が実行される
    func setTopicsToScreen(_ topics: [TopicsModel]) {
        targetTopics = topics
    }
}

