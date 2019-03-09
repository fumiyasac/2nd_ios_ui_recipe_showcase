//
//  DetailViewController.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import WaterfallLayout
import AlamofireImage

final class DetailViewController: UIViewController {

    // メインとなる画像表示部分の本来の高さ
    private let originalDetailImageViewHeight: CGFloat = 240.0

    // ViewModelの初期化に必要な要素の定義
    private let notificationCenter = NotificationCenter()
    private let api = ArticleAPIManager.shared

    // ViewModelの初期化
    private lazy var viewModel = DetailViewModel(notificationCenter: notificationCenter, api: api)

    // 遷移元から引き渡されるIDとPhotoEntity
    // MEMO: 最初は一覧ページから引き継いだデータを表示し、その後APIから再取得した情報を反映させる形の処理をする
    private var targetMainArticleEntity: MainArticleEntity? = nil

    // 表示内容を一時的に格納するための変数(おすすめ記事データ)
    private var detailRecommendLists: [DetailRecommendEntity] = [] {
        didSet {
            self.reloadDetailRecommendCollectionView()
        }
    }

    @IBOutlet weak private var detailScrollView: UIScrollView!
    @IBOutlet weak private var detailImageView: UIImageView!
    @IBOutlet weak private var detailMainArticleElementView: DetailMainArticleElementView!
    @IBOutlet weak private var detailRecommendCollectionView: UICollectionView!
    @IBOutlet weak private var detailRecommendErrorView: DetailRecommendErrorView!

    // おすすめ記事データ表示用のUICollectionViewに対する高さの制約
    @IBOutlet weak private var detailRecommendCollectionViewHeightConstraint: NSLayoutConstraint!

    // メインとなる画像表示部分のUIImageViewに対する高さと上方向の制約
    @IBOutlet weak private var detailImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var detailImageViewTopConstraint: NSLayoutConstraint!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle("風景写真の詳細表示")
        setupDetailScrollView()
        setupNotificationsForDataBinding()
        setupTargetViewsForArticleById()
        setupTargetViewsForDetailRecommend()
    }

    // MARK: - Function

    func setMainArticleEntityFromPresentedViewController(_ entity: MainArticleEntity) {
        targetMainArticleEntity = entity
    }

    // MARK: - Private Function

    // 詳細表示用のデータ取得成功の通知を受信した際に実行される処理
    @objc private func updateStateForArticleByIdSuccess(notification: Notification) {

        // IDに紐づく表示内容(変数: targetMainArticleEntity)を更新してUIへ反映する
        targetMainArticleEntity = viewModel.targetDetailArticle
        reflectMainArticleEntityInformation()
    }

    // 詳細表示用のデータ取得失敗の通知を受信した際に実行される処理
    @objc private func updateStateForArticleByIdFailure(notification: Notification) {

        // 失敗した際にはポップアップを表示して記事の再取得を促す
        showAlertWith(completionHandler: {
            if let targetId = self.targetMainArticleEntity?.id {
                self.viewModel.fetchDetailArtcleBy(targetId: targetId)
            }
        })
    }

    // おすすめ表示用のデータ取得成功の通知を受信した際に実行される処理
    @objc private func updateStateForDetailRecommendSuccess(notification: Notification) {

        // おすすめ表示用に配置したUICollectionViewを表示させる
        detailRecommendErrorView.isHidden = true
        detailRecommendCollectionView.isHidden = false
        detailRecommendLists = viewModel.targetDetailRecommendLists
    }

    // おすすめ表示用のデータ取得失敗の通知を受信した際に実行される処理
    @objc private func updateStateForDetailRecommendFailure(notification: Notification) {

        // おすすめ表示用のエラー画面のViewを表示させる
        detailRecommendErrorView.isHidden = false
        detailRecommendCollectionView.isHidden = true
        detailRecommendLists = []
    }

    private func setupDetailScrollView() {

        // UIScrollViewに関する設定をする
        // NavigationBar分のスクロール位置がずれてしまわないようにする考慮は下記の通り:
        // 考慮する項目1. Detail.storyboardにおいて「Adjust Scroll View Insets」のチェックを外す
        // 考慮する項目2. detailScrollViewのTopのAutoLayoutを「Detail Scroll View.top = SafeArea.top」とする
        detailScrollView.delegate = self
    }

    // DataBindingを実行するための通知に関する初期設定をする
    private func setupNotificationsForDataBinding() {
        notificationCenter.addObserver(
            self,
            selector: #selector(self.updateStateForArticleByIdSuccess),
            name: viewModel.successFetchArticleById,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(self.updateStateForArticleByIdFailure),
            name: viewModel.failureFetchArticleById,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(self.updateStateForDetailRecommendSuccess),
            name: viewModel.successFetchDetailRecommend,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(self.updateStateForDetailRecommendFailure),
            name: viewModel.failureFetchDetailRecommend,
            object: nil
        )

        // 遷移元の画面から引き渡されたデータを元に処理を実行する
        if let targetId = targetMainArticleEntity?.id {
            // MEMO: ViewModel内に定義したAPIリクエスト処理を実行する
            viewModel.fetchDetailArtcleBy(targetId: targetId)
            viewModel.fetchRecommend()
        } else {
            // MEMO: 本来はエラー発生時の考慮を行う
            print("対象の記事がありません")
        }
    }

    // 記事詳細の表示に関連するView要素の初期設定をする
    private func setupTargetViewsForArticleById() {

        // IDに紐づく表示内容(変数: targetMainArticleEntity)を反映する
        reflectMainArticleEntityInformation()

        // メインとなる画像表示部分の画像の高さや拡大モード等をを設定する
        detailImageView.contentMode = .scaleAspectFill
        detailImageViewHeightConstraint.constant = originalDetailImageViewHeight
    }

    // おすすめ記事データ表示に関連するView要素の初期設定をする
    private func setupTargetViewsForDetailRecommend() {

        // ライブラリ「WaterfallLayout」のインスタンスを作成して設定を適用する
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.sectionInset = UIEdgeInsets(top: 8.0, left: 10.0, bottom: 8.0, right: 10.0)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerHeight = 0.0
        detailRecommendCollectionView.setCollectionViewLayout(layout, animated: true)
        detailRecommendCollectionView.collectionViewLayout = layout

        // おすすめ記事データ表示のUICollectionViewを設定する
        detailRecommendCollectionView.isScrollEnabled = false
        detailRecommendCollectionView.registerCustomCell(DetailRecommendCollectionViewCell.self)
        detailRecommendCollectionView.registerCustomReusableHeaderView(DetailRecommendHeaderView.self)
        detailRecommendCollectionView.registerCustomReusableFooterView(DetailRecommendFooterView.self)
        detailRecommendCollectionView.dataSource = self
        detailRecommendCollectionView.delegate = self

        // おすすめ記事データ表示のUICollectionViewの初期高さ制約を0にしておく
        detailRecommendCollectionViewHeightConstraint.constant = 0

        // エラー発生時のViewに関する初期設定
        detailRecommendErrorView.isHidden = true
        detailRecommendErrorView.requestRecommendButtonAction = {
            self.viewModel.fetchRecommend()
        }
    }

    // 取得した記事データの内容を反映する
    private func reflectMainArticleEntityInformation() {

        if let entity = targetMainArticleEntity {

            // 概要などのテキスト表示部分を反映する
            detailMainArticleElementView.setEntity(entity)

            // メインとなる画像表示部分を反映する
            if let thumbnailURL = entity.thumbnailUrl {
                detailImageView.af_setImage(withURL: thumbnailURL)
            }
        }
    }

    // 配置したUICollectionViewの表示をリロードする
    private func reloadDetailRecommendCollectionView() {
        detailRecommendCollectionView.reloadData()
        detailRecommendCollectionView.performBatchUpdates({
            self.detailRecommendCollectionViewHeightConstraint.constant =
                self.detailRecommendCollectionView.contentSize.height
        })
    }

    // エラー発生時のアラート表示を設定をする
    private func showAlertWith(completionHandler: (() -> ())? = nil) {
        let alert = UIAlertController(
            title: "エラーが発生しました",
            message: "記事詳細データの取得に失敗しました。通信環境等を確認の上再度お試し下さい。",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            completionHandler?()
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UIScrollViewDelegate

extension DetailViewController: UIScrollViewDelegate {

    // スクロールが実行された際にトップ画像に視差効果を付与する
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailImageViewTopConstraint.constant = min(scrollView.contentOffset.y, 0)
        detailImageViewHeightConstraint.constant = max(0, originalDetailImageViewHeight - scrollView.contentOffset.y)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    // 配置対象のセクションの個数を設定する
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // 配置対象のセクションにおけるUICollectionReusableViewのHeaderサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return DetailRecommendHeaderView.viewSize
    }

    // 配置対象のセクションにおけるUICollectionReusableViewのFooterサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return DetailRecommendFooterView.viewSize
    }

    // 配置対象のセクションにおけるUICollectionReusableViewの設定する
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableCustomHeaderView(with: DetailRecommendHeaderView.self, indexPath: indexPath)
        } else if kind == UICollectionView.elementKindSectionFooter {
            return collectionView.dequeueReusableCustomFooterView(with: DetailRecommendFooterView.self, indexPath: indexPath)
        } else {
            return UICollectionReusableView()
        }
    }

    // 配置対象のセクションに配置するセルの個数を設定する
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailRecommendLists.count
    }

    // 配置対象のセクション配置するセル要素を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: DetailRecommendCollectionViewCell.self, indexPath: indexPath)
        cell.setCell(detailRecommendLists[indexPath.row])
        return cell
    }
}

// MARK: - WaterfallLayoutDelegate

extension DetailViewController: WaterfallLayoutDelegate {

    // ライブラリ「WaterfallLayout」における配置対象のセルのサイズを指定する
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // セルのサイズ調整用の値(写真の比率と調和するように調整を加える)
        let adjustRatio: CGFloat = 2.6
        let cellWidth: CGFloat = UIScreen.main.bounds.width / 2.0
        var cellHeight: CGFloat = 120

        // 取得した画像を元に高さの調節を行う
        let targetDetailRecommend = detailRecommendLists[indexPath.row]
        if let imageURL = targetDetailRecommend.imageUrl {
            do {
                let data = try Data(contentsOf: imageURL)
                let image = UIImage(data: data)
                let height = image?.size.height ?? 0
                cellHeight += height / adjustRatio
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }

    // ライブラリ「WaterfallLayout」における配置対象のセクション用Headerの高さを指定する
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, headerHeightFor section: Int) -> CGFloat? {
        return DetailRecommendHeaderView.viewSize.height
    }

    // ライブラリ「WaterfallLayout」における配置対象のセクション用Footerの高さを指定する
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, footerHeightFor section: Int) -> CGFloat? {
        return DetailRecommendFooterView.viewSize.height
    }

    // ライブラリ「WaterfallLayout」における配置対象のセル表示パターンを指定する
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        return .waterfall(column: 2, distributionMethod: .balanced)
    }
}
