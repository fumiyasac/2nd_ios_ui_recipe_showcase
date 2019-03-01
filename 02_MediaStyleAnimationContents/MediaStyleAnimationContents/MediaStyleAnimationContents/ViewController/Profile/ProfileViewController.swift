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

    private func showToastForAnnounce() {
        let centerX: CGFloat = UIScreen.main.bounds.width / 2
        let centerY: CGFloat = 96.0
        let toastShowPoint = CGPoint(x: centerX, y: centerY)

        var style = ToastStyle()
        style.titleFont = UIFont(name: "HiraKakuProN-W6", size: 11.0)!
        style.messageFont = UIFont(name: "HiraKakuProN-W3", size: 10.0)!
        style.messageColor = .white
        style.backgroundColor = UIColor(code: "#333333", alpha: 0.5)

        self.view.makeToast("This is Webview which displays target articles of 'New York Times.'", duration: 1.0, point: toastShowPoint, title: "Thanks for watching my sample!", image: nil, completion: nil)
    }
}
