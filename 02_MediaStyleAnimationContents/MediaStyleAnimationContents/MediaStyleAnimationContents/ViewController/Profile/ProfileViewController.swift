//
//  ProfileViewController.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import Toast_Swift

final class ProfileViewController: UIViewController {

    private var targetProfiles: [ProfileLists] = [] {
        didSet {
            self.profileTableView.reloadData()
        }
    }

    @IBOutlet weak private var profileTableView: UITableView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle("開発者のソーシャルリンク集")
        setupProfileTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 一番最初だけToast表示を実行する
        showToastForAnnounce()
    }

    // MARK: - Private Function

    private func setupProfileTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.rowHeight = 72.0
        profileTableView.registerCustomCell(ProfileTableViewCell.self)
        targetProfiles = ProfileLists.allCases
    }

    // 広告表示用のViewをToast表示のように表示させる
    private func showToastForAnnounce() {
        let advertisementView = ToastAdvertisementView()
        advertisementView.frame = CGRect(x: 0, y: 0, width: 300.0, height: 84.0)
        advertisementView.openAdvertisementButtonAction = {
            if let url = URL(string: "https://nextpublishing.jp/book/10500.html") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                    self.showAlertWith(completionHandler: nil)
                }
            }
        }
        self.view.showToast(advertisementView)
    }

    // MEMO: iOS14からSafari以外のブラウザをデフォルトに変更することが可能です。
    // その場合には「LSApplicationQueriesSchemes」の設定をしないとcanOpenURLでfalseになってしまいます。
    // ※ 詳細はInfo.plistを参照
    // 確認したSafari以外のブラウザは下記の通りになります。
    // - Google Chrome / Smooz
    private func showAlertWith(completionHandler: (() -> ())? = nil) {
        let alert = UIAlertController(
            title: "リンクを開くことができませんでした。",
            message: "アプリ内部の設定が誤っている可能性があります。",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            completionHandler?()
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetProfiles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: ProfileTableViewCell.self)
        cell.setCell(targetProfiles[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetProfile = targetProfiles[indexPath.row]
        if let url = targetProfile.getLink() {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            } else {
                showAlertWith(completionHandler: nil)
            }
        }
    }
}
