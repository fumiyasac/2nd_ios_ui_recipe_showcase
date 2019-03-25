//
//  DetailGiftViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FloatingPanel

final class DetailGiftViewController: ZoomImageTransitionViewController {

    private let floatingPanel: FloatingPanelController = FloatingPanelController()

    @IBOutlet weak var detailGiftImageView: UIImageView!
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFloatingPanel()
        detailGiftImageView.image = UIImage(named: "sample_image")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // セミモーダルビューを非表示にする
        floatingPanel.removePanelFromParent(animated: true)
    }

    override func createTransitionImageView() -> UIImageView {
        let imageView = UIImageView(image: detailGiftImageView.image)
        imageView.contentMode = detailGiftImageView.contentMode
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.frame = detailGiftImageView.frame
        return imageView
    }

    // MARK: - Function

    func setDetailImage(_ targetImage: UIImageView) {
        detailGiftImageView = targetImage
    }

    // MARK: - Private Function

    private func setupFloatingPanel() {

        // セミモーダルビューで表示する画面をFloatingPanelControllerへセットする
        let detailCommentViewController = DetailCommentViewController.instantiate()
        floatingPanel.set(contentViewController: detailCommentViewController)

        // セミモーダルビューを表示する
        floatingPanel.addPanel(toParent: self, belowView: nil, animated: true)
    }
}

// MARK: - StoryboardInstantiatable

extension DetailGiftViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Detail"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return DetailGiftViewController.className
    }
}
