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

    // MARK: - Function

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
        let layout = AnimatedCollectionViewLayout()
        layout.animator = CubeAttributesAnimator()
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

    // タブ用のセルにおける矩形サイズを設定する（※ここでは画面サイズに仮置きする）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
