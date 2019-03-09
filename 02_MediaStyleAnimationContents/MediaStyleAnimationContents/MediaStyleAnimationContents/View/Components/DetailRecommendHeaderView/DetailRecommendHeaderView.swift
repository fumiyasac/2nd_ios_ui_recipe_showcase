//
//  DetailRecommendHeaderView.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/09.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FontAwesome_swift

final class DetailRecommendHeaderView: UICollectionReusableView {

    static let viewSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 48.0)

    @IBOutlet weak private var foodImageView: UIImageView!

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupFoodImageView()
    }

    // MARK: - Private Function

    private func setupFoodImageView() {

        // FontAwesomeのアイコンに関する設定
        let iconColor: UIColor = UIColor(code: "#cf504c")
        let iconSize: CGSize = CGSize(width: 16.0, height: 16.0)

        foodImageView.image = UIImage.fontAwesomeIcon(name: .hamburger, style: .solid, textColor: iconColor, size: iconSize)
    }
}
