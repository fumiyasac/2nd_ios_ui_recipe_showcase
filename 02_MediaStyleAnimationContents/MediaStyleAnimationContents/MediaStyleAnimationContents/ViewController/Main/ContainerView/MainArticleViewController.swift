//
//  MainArticleViewController.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

// MARK: - Protocol

// このViewControllerのプロトコルを定義する
// MEMO: 親となるMainViewControllerへ処理を渡す役割を担う
protocol MainArticleViewControllerDelegate: NSObjectProtocol {

    // このViewControllerを表示するために配置したContainerViewの高さを更新する
    func updateContainerViewHeight(_ height: CGFloat)

    // タップされたセルの情報を引き渡す
    func sendTargetEntity(_ entity: MainArticleEntity)
}

final class MainArticleViewController: UIViewController {

    // 表示内容を一時的に格納するための変数
    private var mainArticleLists: [MainArticleEntity] = [] {
        didSet {
            self.reloadMainArticleTableView()
        }
    }

    // ViewModelの初期化に必要な要素の定義
    private let notificationCenter = NotificationCenter()
    private let api = ArticleAPIManager.shared

    // ViewModelの初期化
    private lazy var viewModel = MainArticleViewModel(notificationCenter: notificationCenter, api: api)

    // MainArticleViewControllerDelegateの宣言
    weak var delegate: MainArticleViewControllerDelegate?

    @IBOutlet weak private var mainArticleTableView: UITableView!
    @IBOutlet weak private var mainArticleRequestButtonView: MainArticleRequestButtonView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotificationsForDataBinding()
        setupMainArticleTableView()
        setupMainArticleRequestButtonView()
    }

    // MARK: - Private Function

    // データ取得中の通知を受信した際に実行される処理
    @objc private func updateStateForFetching(notification: Notification) {

        // 配置したView要素のユーザー操作に関わる変更
        denyUserInterations()
    }
    
    // データ取得成功の通知を受信した際に実行される処理
    @objc private func updateStateForSuccess(notification: Notification) {

        // 配置したView要素のユーザー操作に関わる変更
        allowUserInterations()

        // 次をデータを取得するボタンの表示可否
        mainArticleRequestButtonView.isHidden = !viewModel.hasNextPage

        // データ表示に関わる変更
        mainArticleLists = viewModel.targetMainArticleLists
    }
    
    // データ取得失敗の通知を受信した際に実行される処理
    @objc private func updateStateForFailure(notification: Notification) {

        // 配置したView要素のユーザー操作に関わる変更
        allowUserInterations()

        // 失敗した際にはポップアップを表示して記事の再取得を促す
        showAlertWith(completionHandler: {
            self.viewModel.fetchMainArtcle()
        })
    }

    // DataBindingを実行するための通知に関する初期設定をする
    private func setupNotificationsForDataBinding() {

        // MEMO: NotificationCenterを利用してViewModel側の変更を取得できるようにしている
        // 書籍「iOS設計パターン入門 第6章 MVVM」で紹介されていたコードを参考に構築しました。
        notificationCenter.addObserver(
            self,
            selector: #selector(self.updateStateForFetching),
            name: viewModel.executingFetchMainArticle,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(self.updateStateForSuccess),
            name: viewModel.successFetchMainArticle,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(self.updateStateForFailure),
            name: viewModel.failureFetchMainArticle,
            object: nil
        )
        viewModel.fetchMainArtcle()
    }

    // 記事表示用のUITableViewの初期設定をする
    private func setupMainArticleTableView() {
        mainArticleTableView.rowHeight = MainArticleTableViewCell.cellHeight
        mainArticleTableView.delaysContentTouches = false
        mainArticleTableView.isScrollEnabled = false
        mainArticleTableView.registerCustomCell(MainArticleTableViewCell.self)
        mainArticleTableView.delegate = self
        mainArticleTableView.dataSource = self

        // 初期状態での高さを設定する
        self.delegate?.updateContainerViewHeight(MainArticleRequestButtonView.viewHeight)
    }

    // APIへのリクエストを行うボタン用を含むViewの初期設定をする
    private func setupMainArticleRequestButtonView() {
        mainArticleRequestButtonView.requestNextArticlesButtonAction = {
            self.viewModel.fetchMainArtcle()
        }
    }

    // 配置したUITableViewの表示をリロードする
    private func reloadMainArticleTableView() {
        mainArticleTableView.reloadData()

        // 高さの更新を親のViewControllerへ伝える
        let tableViewHeight = MainArticleTableViewCell.cellHeight * CGFloat(mainArticleLists.count)
        let buttonViewHeight = MainArticleRequestButtonView.viewHeight
        let targetHeight = tableViewHeight + buttonViewHeight
        self.delegate?.updateContainerViewHeight(targetHeight)
    }
    
    // この画面におけるユーザー操作を受け付ける状態にする
    private func allowUserInterations() {
        mainArticleTableView.alpha = 1
        mainArticleTableView.isUserInteractionEnabled = true
        mainArticleRequestButtonView.changeState(isLoading: false)
    }
    
    // この画面におけるユーザー操作を受け付けない状態にする
    private func denyUserInterations() {
        mainArticleTableView.alpha = 0.6
        mainArticleTableView.isUserInteractionEnabled = false
        mainArticleRequestButtonView.changeState(isLoading: true)
    }

    // エラー発生時のアラート表示を設定をする
    private func showAlertWith(completionHandler: (() -> ())? = nil) {
        let alert = UIAlertController(
            title: "エラーが発生しました",
            message: "記事一覧データの取得に失敗しました。通信環境等を確認の上再度お試し下さい。",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            completionHandler?()
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainArticleViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainArticleLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: MainArticleTableViewCell.self)
        let targetEntity = mainArticleLists[indexPath.row]
        cell.setCell(targetEntity)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetEntity = mainArticleLists[indexPath.row]
        self.delegate?.sendTargetEntity(targetEntity)
    }
}
