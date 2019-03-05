//
//  MainSliderErrorView.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/06.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

final class MainSliderErrorView: CustomViewBase {

    var requestSliderButtonAction: (() -> ())?

    @IBOutlet weak private var requestSliderButton: UIButton!

    // MARK: - Initializer
    
    required init(frame: CGRect) {
        super.init(frame: frame)

        setupRequestSliderButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupRequestSliderButton()
    }

    // MARK: - Private Function

    @objc private func executeRequestSliderButtonAction() {
        requestSliderButtonAction?()
    }

    // ボタン部分の初期設定を行う
    private func setupRequestSliderButton() {
        requestSliderButton.superview?.layer.borderWidth = 0.5
        requestSliderButton.superview?.layer.borderColor = UIColor(code: "#cf504c").cgColor
        requestSliderButton.superview?.layer.cornerRadius = requestSliderButton.frame.height / 2
        requestSliderButton.addTarget(self, action: #selector(self.executeRequestSliderButtonAction), for: .touchUpInside)
    }
}
