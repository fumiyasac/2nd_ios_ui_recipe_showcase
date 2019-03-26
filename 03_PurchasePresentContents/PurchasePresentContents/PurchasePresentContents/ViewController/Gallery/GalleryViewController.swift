//
//  GalleryViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

final class GalleryViewController: UIViewController {

    //private var galleryList: [Galley] = []

    @IBOutlet weak private var galleryCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGalleryCollectionView()
    }

    // MARK: - @IBAction

    @IBAction func clonseGalleryAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Private Function

    private func setupGalleryCollectionView() {

        // UICollectionViewに関する初期設定
        galleryCollectionView.isPagingEnabled = true
        galleryCollectionView.isScrollEnabled = true
        galleryCollectionView.showsHorizontalScrollIndicator = false
        galleryCollectionView.showsVerticalScrollIndicator = false

        // UICollectionViewDelegate & UICollectionViewDataSourceに関する初期設定
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.registerCustomCell(GalleryCollectionViewCell.self)

        // UICollectionViewに付与するアニメーションに関する設定
        // MEMO: AnimatedCollectionViewLayoutでカードが回転するアニメーションを加える
        let layout = AnimatedCollectionViewLayout()
        layout.animator = RotateInOutAttributesAnimator()
        layout.scrollDirection = .horizontal
        galleryCollectionView.collectionViewLayout = layout
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: GalleryCollectionViewCell.self, indexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - StoryboardInstantiatable

extension GalleryViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Gallery"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
