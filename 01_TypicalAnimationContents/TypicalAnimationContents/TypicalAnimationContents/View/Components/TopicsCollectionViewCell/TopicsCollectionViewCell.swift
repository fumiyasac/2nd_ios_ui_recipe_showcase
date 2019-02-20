//
//  TopicsCollectionViewCell.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

class TopicsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var topicsCardView: TopicsCardView!

    // MARK: - Function

    func setCell(_ topic: TopicsModel) {
        topicsCardView.setView(topic)
    }
}
