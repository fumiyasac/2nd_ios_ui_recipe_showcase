//
//  PhotoGalleryViewController.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class PhotoGalleryViewController: UIViewController {

    private let cellMargin: CGFloat = 10.0

    private var targetPhotos: [PhotoGalleryModel] = [] {
        didSet {
            self.photoGalleryCollectionView.reloadData()
        }
    }
    private var preseter: PhotoGalleryPresenter!

    @IBOutlet weak private var photoGalleryCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(MainTabBarItems.photos.getTitle())
        setupPhotoListCollectionView()
        setupGallryPresenter()
    }

    // MARK: - Private Function

    private func setupPhotoListCollectionView() {
        photoGalleryCollectionView.dataSource = self
        photoGalleryCollectionView.contentInset = UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
        photoGalleryCollectionView.registerCustomCell(PhotoGalleryCollectionViewCell.self)

        // MEMO: 自作したMasonryCollectionViewLayoutクラスに定義したMasonryLayoutDelegateを適用する
        // MEMO: MasonryCollectionViewLayoutクラスはUICollectionViewのHeader/Footerに関する考慮は行なっていない
        if let photoListCollectionViewLayout = photoGalleryCollectionView.collectionViewLayout as? MasonryCollectionViewLayout {
            photoListCollectionViewLayout.delegate = self
        }
    }

    private func setupGallryPresenter() {
        preseter = PhotoGalleryPresenter()
        preseter.delegate = self
        preseter.getPhotoList()
    }
}

// MARK: - UICollectionViewDataSource

extension PhotoGalleryViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return targetPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: PhotoGalleryCollectionViewCell.self, indexPath: indexPath)
        cell.setCell(targetPhotos[indexPath.row])
        return cell
    }
}

// MARK: - PhotoGalleryPresenterDelegate

extension PhotoGalleryViewController: PhotoGalleryPresenterDelegate {

    // MEMO: 値がセットされたタイミングで更新処理が実行される
    func setPhotosToScreen(_ photos: [PhotoGalleryModel]) {
        targetPhotos = photos
    }
}

// MARK: - MasonryLayoutDelegate

extension PhotoGalleryViewController: MasonryLayoutDelegate {

    // UICollectionViewCellへ表示対象の画像の高さを取得して返す
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let targetPhoto = targetPhotos[indexPath.row]
        return targetPhoto.image.size.height
    }
}
