//
//  InformationDetailHeaderView.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import FontAwesome_swift

// MEMO: 今回はサンプルなので具体的な処理は実装していませんのでご了承ください😓
final class InformationDetailHeaderView: CustomViewBase {

    private let iconSize: CGSize = CGSize(width: 16.0, height: 16.0)
    private let iconColor: UIColor = .white

    @IBOutlet weak private var iconImageView: UIImageView!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInformationDetailHeaderView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupInformationDetailHeaderView()
    }

    // MARK: - Private Function

    private func setupInformationDetailHeaderView() {
        iconImageView.image = UIImage.fontAwesomeIcon(name: .caretDown, style: .solid, textColor: iconColor, size: iconSize)
    }
}
