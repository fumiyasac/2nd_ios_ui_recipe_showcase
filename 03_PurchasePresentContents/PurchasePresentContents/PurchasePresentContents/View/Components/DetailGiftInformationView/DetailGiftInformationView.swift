//
//  DetailGiftInformationView.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/26.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

final class DetailGiftInformationView: CustomViewBase {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var purchaseGiftButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupPurchaseGiftButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupPurchaseGiftButton()
    }

    // MARK: - Function

    func setGiftData(_ giftEntity: GiftEntity) {

        // 商品名表示の設定
        nameLabel.text = giftEntity.giftName

        // 値段表示の設定
        priceLabel.text = "PRICE: \(giftEntity.price)"

        // カテゴリー表示の設定
        if let category = CategoryType(rawValue: giftEntity.categoryId) {
            categoryLabel.text = "CATEGORY: \(category.getTitle())"
            categoryLabel.textColor = category.getColor()
        }
    }

    // MARK: - Private Function

    private func setupPurchaseGiftButton() {
        purchaseGiftButton.superview?.layer.borderWidth = 0.5
        purchaseGiftButton.superview?.layer.borderColor = UIColor(code: "#ffae00").cgColor
        purchaseGiftButton.superview?.layer.cornerRadius = purchaseGiftButton.frame.height / 2

        // MEMO: 今回はサンプルなので購入ボタンを非活性状態にする
        purchaseGiftButton.superview?.alpha = 0.6
        purchaseGiftButton.isEnabled = false
    }
}
