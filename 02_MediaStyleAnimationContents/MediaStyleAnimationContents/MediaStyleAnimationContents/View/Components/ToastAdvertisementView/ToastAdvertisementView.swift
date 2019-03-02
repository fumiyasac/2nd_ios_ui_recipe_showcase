//
//  ToastAdvertisementView.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/02.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

final class ToastAdvertisementView: CustomViewBase {

    // MEMO: ボタン押下時の挙動はViewControllerで実装する
    var openAdvertisementButtonAction: (() -> ())?

    @IBOutlet weak private var openAdvertisementButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupToastAdvertisementView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupToastAdvertisementView()
    }

    // MARK: - Private Function
 
    @objc private func executeOpenAdvertisementButtonAction() {
        openAdvertisementButtonAction?()
    }

    private func setupToastAdvertisementView() {

        // 広告表示用のボタンで必要な初期設定
        openAdvertisementButton.addTarget(self, action: #selector(self.executeOpenAdvertisementButtonAction), for: .touchUpInside)
    }
}
