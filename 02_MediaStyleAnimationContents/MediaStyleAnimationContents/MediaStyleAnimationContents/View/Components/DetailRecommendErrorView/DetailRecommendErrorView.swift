//
//  DetailRecommendErrorView.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/09.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

final class DetailRecommendErrorView: CustomViewBase {

    var requestRecommendButtonAction: (() -> ())?

    @IBOutlet weak private var requestRecommendButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupRequestRecommendButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupRequestRecommendButton()
    }

    // MARK: - Private Function

    @objc private func executeRequestRecommendButtonAction() {
        requestRecommendButtonAction?()
    }

    // ボタン部分の初期設定を行う
    private func setupRequestRecommendButton() {
        requestRecommendButton.superview?.layer.borderWidth = 0.5
        requestRecommendButton.superview?.layer.borderColor = UIColor(code: "#cf504c").cgColor
        requestRecommendButton.superview?.layer.cornerRadius = requestRecommendButton.frame.height / 2
        requestRecommendButton.addTarget(self, action: #selector(self.executeRequestRecommendButtonAction), for: .touchUpInside)
    }
}
