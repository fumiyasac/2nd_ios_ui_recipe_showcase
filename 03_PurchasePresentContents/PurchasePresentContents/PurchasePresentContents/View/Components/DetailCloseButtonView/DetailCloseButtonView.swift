//
//  DetailCloseButtonView.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/26.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

final class DetailCloseButtonView: CustomViewBase {

    var closeDetailButtonAction: (() -> ())?

    private let iconSize: CGSize = CGSize(width: 32.0, height: 32.0)
    private let iconColor: UIColor = UIColor(code: "#ffae00")

    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var closeDetailButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupDetailCloseButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupDetailCloseButtonView()
    }

    // MARK: - Private Function

    @objc private func executeCloseDetailButtonAction() {
        closeDetailButtonAction?()
    }

    private func setupDetailCloseButtonView() {
        self.backgroundColor = .clear
        iconImageView.image = UIImage.fontAwesomeIcon(name: .chevronLeft, style: .solid, textColor: iconColor, size: iconSize)
        closeDetailButton.addTarget(self, action: #selector(self.executeCloseDetailButtonAction), for: .touchUpInside)
    }
}
