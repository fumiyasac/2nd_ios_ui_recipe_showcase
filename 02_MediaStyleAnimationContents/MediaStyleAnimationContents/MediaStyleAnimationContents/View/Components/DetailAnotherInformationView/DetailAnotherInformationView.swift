//
//  DetailMarkdownView.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/09.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

final class DetailAnotherInformationView: CustomViewBase {

    @IBOutlet weak private var bookImageView: UIImageView!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupDetailAnotherInformationView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupDetailAnotherInformationView()
    }

    // MARK: - Private Function

    private func setupDetailAnotherInformationView() {

        // FontAwesomeのアイコンに関する設定
        let iconColor: UIColor = UIColor(code: "#cf504c")
        let iconSize: CGSize = CGSize(width: 16.0, height: 16.0)

        bookImageView.image = UIImage.fontAwesomeIcon(name: .book, style: .solid, textColor: iconColor, size: iconSize)
    }
}
