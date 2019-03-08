//
//  QiitaViewController.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

import BTNavigationDropdownMenu
import SVProgressHUD
import FontAwesome_swift

final class QiitaViewController: UIViewController {

    // MEMO: WKWebViewはコードで配置してAutoLayoutで制約をつける
    private var webView: WKWebView!

    // NavigationBarで表示するドロップダウンメニュー
    private var dropdownMenuView: BTNavigationDropdownMenu!

    // Enumで定義したQiita記事用の変数
    private var selectedQiitaContents: QiitaContentsLists! {
        didSet {
            self.requestQiitaUrl()
        }
    }

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebview()
        setupDropdownMenuView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // MEMO: メニューを表示した状態から前の画面へ戻る場合の考慮
        dropdownMenuView.hide()

        // MEMO: WebView読み込み時に前の画面へ戻る場合の考慮
        SVProgressHUD.dismiss()
    }

    // MARK: - Private Function

    private func setupWebview() {

        // WKWebViewを作成と設定
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.allowsBackForwardNavigationGestures = true
        webView.backgroundColor = .white
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        // WKWebViewを追加してし制約を付与する
        self.view.addSubview(webView)

        // コードによるAutoLayoutの制約をWKWebViewへ付与する
        webView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            webView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
            webView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        } else {
            webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        }
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        // 取得したURLページをセットする
        selectedQiitaContents = .passcodeLock
    }

    // ドロップダウンメニューに関する初期設定をする
    private func setupDropdownMenuView() {

        // ドロップダウンメニューに必要なデータの準備をする
        let titles = QiitaContentsLists.allCases.map{ $0.getTitle() }

        // ドロップダウンメニューに関して必要な初期設定をする
        dropdownMenuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(0), items: titles)
        self.navigationItem.titleView = dropdownMenuView

        // ドロップダウンメニュー内のセルをタップした際は該当の情報を表示する
        dropdownMenuView.didSelectItemAtIndexHandler = { (indexPath: Int) in
            self.selectedQiitaContents = QiitaContentsLists.allCases[indexPath]
        }

        // ドロップダウンメニューに関するデザイン設定をする
        setupDropDownMenuDecoration()
    }

    private func setupDropDownMenuDecoration() {

        // MEMO: セルの要素に関する設定
        dropdownMenuView.cellHeight = 58
        dropdownMenuView.cellBackgroundColor = .white
        dropdownMenuView.cellSeparatorColor = UIColor(code: "#ccccc3")
        dropdownMenuView.cellSelectionColor = UIColor(code: "#f7f7f7")
        dropdownMenuView.cellTextLabelColor = .gray
        dropdownMenuView.cellTextLabelFont = UIFont(name: "HiraKakuProN-W3", size: 12.0)
        dropdownMenuView.cellTextLabelAlignment = .left
        dropdownMenuView.shouldKeepSelectedCellColor = true

        // MEMO: セルのアイコン表示に関する設定
        let iconSize = CGSize(width: 16.0, height: 16.0)
        dropdownMenuView.arrowPadding = 15
        dropdownMenuView.checkMarkImage = UIImage.fontAwesomeIcon(name: .checkCircle, style: .solid, textColor: .gray, size: iconSize)

        // MEMO: ナビゲーションバーのタイトル表示に関する設定
        dropdownMenuView.navigationBarTitleFont = UIFont(name: "HiraKakuProN-W6", size: 14.0)

        // MEMO: ドロップダウンメニュー表示に関する設定
        dropdownMenuView.animationDuration = 0.24
        dropdownMenuView.maskBackgroundColor = .black
        dropdownMenuView.maskBackgroundOpacity = 0.72
    }

    private func requestQiitaUrl() {
        if let url = selectedQiitaContents.getUrl() {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
}

// MARK: - WKUIDelegate, WKNavigationDelegate

extension QiitaViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {

        // WKWebView内で<a>タグのリンクがクリックされた際はWebView内での画面遷移を許可しない
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            if let url = navigationAction.request.url {
                openURL(url)
                decisionHandler(.cancel)
                return
            }
        }

        // WKWebView内での画面遷移を許可する
        decisionHandler(.allow)
    }

    // WKWebViewで読み込みが開始された際に実行する処理
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        // 配置したWebViewやドロップダウンメニューの操作に関する設定
        webView.alpha = 0.46
        webView.isUserInteractionEnabled = false
        dropdownMenuView.isUserInteractionEnabled = false

        // プログレスバー表示に関する設定
        SVProgressHUD.setBackgroundColor(UIColor(code: "#f3f3f3"))
        SVProgressHUD.show(withStatus: "記事データ読み込み中...")
    }

    // WKWebViewで読み込みが完了した際に実行する処理
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        // 配置したWebViewやドロップダウンメニューの操作に関する設定
        webView.alpha = 1
        webView.isUserInteractionEnabled = true
        dropdownMenuView.isUserInteractionEnabled = true

        // プログレスバー表示に関する設定
        SVProgressHUD.dismiss()
    }

    // WKWebViewで読み込みが失敗した際に実行する処理
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {

        // 配置したWebViewやドロップダウンメニューの操作に関する設定
        webView.alpha = 1
        webView.isUserInteractionEnabled = true
        dropdownMenuView.isUserInteractionEnabled = true

        // プログレスバー表示に関する設定
        SVProgressHUD.setBackgroundColor(UIColor(code: "#f3f3f3"))
        SVProgressHUD.showError(withStatus: "エラーが発生しました")
    }

    // WKWebView内における3Dタッチを設定に関する設定(trueにすると有効になる)
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        return false
    }

    // MARK: - Private Function

    private func openURL(_ url: URL) {

        // MEMO: 下記のクラッシュ防止対策として導入する
        // https://stackoverflow.com/questions/32864287/sfsafariviewcontroller-crash-the-specified-url-has-an-unsupported-scheme
        if let urlScheme = url.scheme {
            let isValidScheme = ["http", "https"].contains(urlScheme.lowercased())
            if isValidScheme {
                let safariVC = SFSafariViewController(url: url)
                self.present(safariVC, animated: true, completion: nil)
            } else {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
