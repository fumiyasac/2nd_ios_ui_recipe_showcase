//
//  InformationDetailFormButtonView.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/24.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MEMO: 今回はサンプルなので具体的な処理は実装していませんのでご了承ください😓
final class InformationDetailFormButtonView: CustomViewBase {

    @IBOutlet weak private var showDetailButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupShowDetailButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupShowDetailButton()
    }

    // MARK: - Private Function

    // ボタン部分の初期設定を行う
    private func setupShowDetailButton() {
        showDetailButton.superview?.layer.borderWidth = 0.5
        showDetailButton.superview?.layer.borderColor = UIColor(code: "#ffae00").cgColor
        showDetailButton.superview?.layer.cornerRadius = showDetailButton.frame.height / 2

        // MEMO: 今回はサンプルなので購入ボタンを非活性状態にする
        showDetailButton.superview?.alpha = 0.6
        showDetailButton.isEnabled = false
    }
}
