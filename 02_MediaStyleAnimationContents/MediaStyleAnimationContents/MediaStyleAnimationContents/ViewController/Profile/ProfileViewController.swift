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

    @IBOutlet weak private var profileTableView: UITableView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 一番最初だけToast表示を実行する
        showToastForAnnounce()
    }

    // MARK: - Private Function

    // 広告表示用のViewをToast表示のように表示させる
    private func showToastForAnnounce() {
        let advertisementView = ToastAdvertisementView()
        advertisementView.frame = CGRect(x: 0, y: 0, width: 300.0, height: 84.0)
        advertisementView.openAdvertisementButtonAction = {
            if let url = URL(string: "https://nextpublishing.jp/book/10500.html") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        self.view.showToast(advertisementView)
    }
}
