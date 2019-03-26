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

    private var floatingPanel: FloatingPanelController!

    @IBOutlet weak var detailGiftImageView: UIImageView!
    @IBOutlet weak private var detailCloseButtonView: DetailCloseButtonView!
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFloatingPanel()
        setupDetailCloseButtonView()
        detailGiftImageView.image = UIImage(named: "sample_image")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        detailCloseButtonView.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        detailCloseButtonView.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // セミモーダルビューを非表示にする
        floatingPanel.removePanelFromParent(animated: false)
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
        floatingPanel = FloatingPanelController()
        floatingPanel.surfaceView.cornerRadius = 24.0
        let detailCommentViewController = DetailCommentViewController.instantiate()
        floatingPanel.set(contentViewController: detailCommentViewController)

        // セミモーダルビューを表示して初期位置を一番下の状態にする
        floatingPanel.addPanel(toParent: self, belowView: nil, animated: true)
        floatingPanel.move(to: .tip, animated: false)

        // FloatingPanelControllerDelegateを適用する
        floatingPanel.delegate = self
    }

    private func setupDetailCloseButtonView() {
        detailCloseButtonView.closeDetailButtonAction = {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - FloatingPanelControllerDelegate

extension DetailGiftViewController: FloatingPanelControllerDelegate {

    //
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return CommentFloatingPanelLayout()
    }

    //
    func floatingPanel(_ vc: FloatingPanelController, behaviorFor newCollection: UITraitCollection) -> FloatingPanelBehavior? {
        return CommentFloatingPanelBehavior()
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
