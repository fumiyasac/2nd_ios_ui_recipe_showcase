//
//  DetailsGiftInformationView.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/26.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

final class DetailsGiftInformationView: CustomViewBase {

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupDetailsGiftInformationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupDetailsGiftInformationView()
    }

    // MARK: - Private Function

    private func setupDetailsGiftInformationView() {
        self.backgroundColor = .clear
    }
}
