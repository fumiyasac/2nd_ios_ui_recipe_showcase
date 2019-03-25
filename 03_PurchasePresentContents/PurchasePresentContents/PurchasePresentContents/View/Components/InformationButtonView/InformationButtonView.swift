//
//  InformationButtonView.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import FontAwesome_swift

final class InformationButtonView: CustomViewBase {

    var showInformationButtonAction: (() -> ())?

    private let iconSize: CGSize = CGSize(width: 30.0, height: 30.0)
    private let iconColor: UIColor = .white

    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var showInformationButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupInformationButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupInformationButtonView()
    }

    // MARK: - Private Function

    @objc private func executeShowInformationButtonAction() {
        showInformationButtonAction?()
    }

    private func setupInformationButtonView() {
        self.backgroundColor = .clear
        iconImageView.image = UIImage.fontAwesomeIcon(name: .newspaper, style: .solid, textColor: iconColor, size: iconSize)
        showInformationButton.superview?.layer.borderWidth = 0.5
        showInformationButton.superview?.layer.borderColor = UIColor(code: "#dddddd").cgColor
        showInformationButton.superview?.layer.cornerRadius = showInformationButton.frame.height / 2
        showInformationButton.addTarget(self, action: #selector(self.executeShowInformationButtonAction), for: .touchUpInside)
    }
}
