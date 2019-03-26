//
//  DetailGalleryInformationView.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/26.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

final class DetailGalleryInformationView: CustomViewBase {

    var showGalleryButtonAction: (() -> ())?

    @IBOutlet weak private var showGalleryButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupShowGalleryButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupShowGalleryButton()
    }

    // MARK: - Private Function

    @objc private func executeShowGalleryButtonAction() {
        showGalleryButtonAction?()
    }

    private func setupShowGalleryButton() {
        showGalleryButton.superview?.layer.borderWidth = 0.5
        showGalleryButton.superview?.layer.borderColor = UIColor(code: "#ffae00").cgColor
        showGalleryButton.superview?.layer.cornerRadius = showGalleryButton.frame.height / 2
        showGalleryButton.addTarget(self, action: #selector(self.executeShowGalleryButtonAction), for: .touchUpInside)
    }
}
