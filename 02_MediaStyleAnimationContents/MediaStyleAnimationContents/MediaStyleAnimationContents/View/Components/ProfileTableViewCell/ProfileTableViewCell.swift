//
//  ProfileTableViewCell.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/03/02.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FontAwesome_swift

final class ProfileTableViewCell: UITableViewCell {

    private let iconSize: CGSize = CGSize(width: 48.0, height: 48.0)

    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupProfileTableViewCell()
    }

    // MARK: - Function

    func setCell(_ profileList: ProfileLists) {
        titleLabel.text = profileList.getTitle()
        descriptionLabel.text = profileList.getDescription()
        iconImageView.image = UIImage.fontAwesomeIcon(name: profileList.getIcon(), style: .solid, textColor: profileList.getColor(), size: iconSize)
    }

    // MARK: - Private Function

    private func setupProfileTableViewCell() {

        // UITableViewCellに関するそれ自体に関する設定
        self.accessoryType = .none
        self.selectionStyle = .none
    }
}
