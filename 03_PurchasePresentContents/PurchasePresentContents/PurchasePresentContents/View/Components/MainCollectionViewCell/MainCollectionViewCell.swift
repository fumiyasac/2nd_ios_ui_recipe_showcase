//
//  MainCollectionViewCell.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import PINRemoteImage
import SkeletonView

final class MainCollectionViewCell: UICollectionViewCell {

    // 各々のセル間につけるマージンの値
    static let cellMargin: CGFloat = 1.0

    // MEMO: この画像の配置位置が欲しいのでprivate(set)にしている
    @IBOutlet weak private(set) var giftImageView: UIImageView!

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!

    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()

        setupMainCollectionViewCell()
    }

    // MARK: - Static Function

    // 画面のサイズを元に算出したセルのサイズを取得する
    static func getCellSize() -> CGSize {

        // 縦方向の隙間・文字表示部分の高さ・画像の縦横比
        let numberOfMargin: CGFloat = 3.0
        let descriptionHeight: CGFloat = 65.0
        let foodImageAspectRatio: CGFloat = 0.75

        // セルのサイズを上記の値を利用して算出する
        let cellWidth  = (UIScreen.main.bounds.width - cellMargin * numberOfMargin) / 2
        let cellHeight = cellWidth * foodImageAspectRatio + descriptionHeight
        return CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Function

    func setCell(_ giftEntity: GiftEntity) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.48, execute: {

            // 商品名表示の設定
            self.nameLabel.text = giftEntity.giftName

            // 値段表示の設定
            self.priceLabel.text = "PRICE: \(giftEntity.price)"

            // カテゴリー表示の設定
            if let category = CategoryType(rawValue: giftEntity.categoryId) {
                self.categoryLabel.text = "CATEGORY: \(category.getTitle())"
                self.categoryLabel.textColor = category.getColor()
            }

            // サムネイル画像の設定
            self.giftImageView.pin_setImage(from: URL(string: giftEntity.imageUrl))

            // スケルトン表示を変更する
            self.setSkeletonableStatus(false)
        })
    }

    // MARK: - Private Function

    private func setupMainCollectionViewCell() {
        self.backgroundColor = UIColor(code: "#efefef")
        giftImageView.contentMode = .scaleAspectFill
        giftImageView.clipsToBounds = true
        setSkeletonableStatus(true)
    }

    // ライブラリ「SkeletonView」の表示を設定する
    private func setSkeletonableStatus(_ result: Bool) {
        let elements = [nameLabel, priceLabel, categoryLabel]
        let _ = elements.map{
            $0?.isSkeletonable = result
            if result {
                $0?.showSkeleton(usingColor: UIColor(code: "#efefef"))
            } else {
                $0?.hideSkeleton()
            }
        }
    }
}
