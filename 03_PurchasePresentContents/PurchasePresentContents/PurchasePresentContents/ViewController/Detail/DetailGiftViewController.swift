//
//  DetailGiftViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import PINRemoteImage
import FloatingPanel

final class DetailGiftViewController: ZoomImageTransitionViewController {

    private var floatingPanel: FloatingPanelController!

    // MEMO: MainViewControllerから引き渡されるデータを格納する
    private var giftEntity: GiftEntity? = nil

    @IBOutlet weak private var detailGiftImageView: UIImageView!
    @IBOutlet weak private var detailCloseButtonView: DetailCloseButtonView!
    @IBOutlet weak private var detailGiftInformationView: DetailGiftInformationView!
    @IBOutlet weak private var detailGalleryInformationView: DetailGalleryInformationView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        // MEMO: 引き渡されたGiftEntityから画像を反映する
        if let gift = giftEntity {
            if let targetImageUrl = URL(string: gift.imageUrl) {
                detailGiftImageView.pin_setImage(from: targetImageUrl)
            }
        }

        setupFloatingPanel()
        setupDetailCloseButtonView()
        setupDetailGiftInformationView()
        setupDetailGalleryInformationView()
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

    func setEntityFromPresentingViewController(_ targetGiftEntity: GiftEntity) {
        giftEntity = targetGiftEntity
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

    private func setupDetailGiftInformationView() {
        guard let gift = giftEntity else {
            fatalError("variable: giftEntity is nil.")
        }
        detailGiftInformationView.setGiftData(gift)
    }

    private func setupDetailGalleryInformationView() {
        detailGalleryInformationView.showGalleryButtonAction = {
            let vc = GalleryViewController.instantiate()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: - FloatingPanelControllerDelegate

extension DetailGiftViewController: FloatingPanelControllerDelegate {

    // FloatingPanelのレイアウト設定に関するクラスを適用する
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return CommentFloatingPanelLayout()
    }

    // FloatingPanelの振る舞い設定に関するクラスを適用する
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
