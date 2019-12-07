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

    // サンプル用の写真情報データを格納するための変数
    private var galleryEntityList: [GalleryEntity] = [] {
        didSet {
            self.galleryCollectionView.reloadData()
        }
    }

    // GalleryPresenterに設定したプロトコルを適用するための変数
    private var presenter: GalleryPresenter!

    @IBOutlet weak private var galleryCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGalleryCollectionView()
        setupGalleryPresenter()
    }

    // MARK: - @IBAction

    // MEMO: 特に画面に直接できるものなら@IBActionにしてしまっても良いと思います
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

        // Ver1.0.0 + iOS13以降の組み合わせの場合CubeAttributesAnimatorがおかしくなるのでVer1.0.1を利用します
        // https://github.com/KelvinJin/AnimatedCollectionViewLayout/issues/54
        layout.animator = RotateInOutAttributesAnimator()
        layout.scrollDirection = .horizontal
        galleryCollectionView.collectionViewLayout = layout
    }

    private func setupGalleryPresenter() {
        presenter = GalleryPresenter(presenter: self)
        presenter.getGalleries()
    }
}

// MARK: - GalleryPresenterProtocol

extension GalleryViewController: GalleryPresenterProtocol {

    func serveGalleryList(_ galleries: [GalleryEntity]) {
        galleryEntityList = galleries
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryEntityList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: GalleryCollectionViewCell.self, indexPath: indexPath)
        cell.setCell(galleryEntityList[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    // セルのサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

    // セルの垂直方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // セルの水平方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // セル内のアイテム間の余白(margin)調整を行う
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
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
