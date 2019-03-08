//
//  MainArticleRequestButtonView.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

final class MainArticleRequestButtonView: CustomViewBase {

    // 利用する画面での想定する高さ
    static let viewHeight: CGFloat = 54.0

    // MEMO: ボタン押下時の挙動はViewControllerで実装する
    var requestNextArticlesButtonAction: (() -> ())?

    // APIリクエスト用のボタン表示で必要なUI部品
    @IBOutlet weak private var normalStateView: UIView!
    @IBOutlet weak private var requestNextArticlesButton: UIButton!
    @IBOutlet weak private var arrowImageView: UIImageView!

    // ローディング中の表示で必要なUI部品
    @IBOutlet weak private var loadingStateView: UIView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupMainArticleRequestButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupMainArticleRequestButtonView()
    }

    // MARK: - Function
    
    func changeState(isLoading: Bool = false) {
        normalStateView.isHidden = isLoading
        loadingStateView.isHidden = !isLoading
    }

    // MARK: - Private Function

    @objc private func executeRequestNextArticlesButtonAction() {
        requestNextArticlesButtonAction?()
    }

    private func setupMainArticleRequestButtonView() {

        // 下向きの矢印表示で必要な初期設定
        let iconColor = UIColor(code: "#cf504c")
        let iconSize  = CGSize(width: 16.0, height: 16.0)
        arrowImageView.image = UIImage.fontAwesomeIcon(name: .arrowDown, style: .solid, textColor: iconColor, size: iconSize)

        // インジケーター表示で必要な初期設定
        activityIndicator.startAnimating()

        // APIリクエスト用のボタンで必要な初期設定
        requestNextArticlesButton.addTarget(self, action: #selector(self.executeRequestNextArticlesButtonAction), for: .touchUpInside)
    }
}
