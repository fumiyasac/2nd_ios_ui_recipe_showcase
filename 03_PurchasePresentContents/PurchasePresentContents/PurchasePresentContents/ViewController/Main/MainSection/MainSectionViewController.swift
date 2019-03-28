//
//  MainSectionViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

protocol MainSectionDelegate: NSObjectProtocol {

    // UIImageViewをプロトコル適用先の画面へ引き渡す
    func serveSelectedDataForPresentedViewController(imageView: UIImageView, giftEntity: GiftEntity)
}

final class MainSectionViewController: UIViewController {

    weak var sectionDelegate: MainSectionDelegate?
    
    // サンプル用のギフト情報データを格納するための変数
    private var giftList: [GiftEntity] = [] {
        didSet {
            self.mainSectionCollectionView.reloadData()
        }
    }

    // GiftPresenterに設定したプロトコルを適用するための変数
    private var presenter: GiftPresenter!

    @IBOutlet weak private var mainSectionCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMainSectionCollectionView()
        setupGiftPresenter()
    }

    // MARK: - Function

    // セクション属性(MainSectionType)に該当するデータを画面に反映する
    // MEMO: このメソッドはUIPageViewControllerを配置している場所から実行する
    func executeGetGiftListBy(mainSectionType: MainSectionType) {
        presenter.getGiftListBy(targetSectionType: mainSectionType)
    }

    // MARK: - Private Function

    private func setupMainSectionCollectionView() {
        mainSectionCollectionView.delegate = self
        mainSectionCollectionView.dataSource = self
        mainSectionCollectionView.registerCustomCell(MainCollectionViewCell.self)
        mainSectionCollectionView.backgroundColor = UIColor(code: "#dddddd")
    }

    private func setupGiftPresenter() {
        presenter = GiftPresenter(presenter: self)
    }
}

// MARK: - GiftPresenterProtocol

extension MainSectionViewController: GiftPresenterProtocol {

    func serveGiftListBySectionType(_ gifts: [GiftEntity]) {
        giftList = gifts
    }
}

// MARK: - UICollectionViewDataSource

extension MainSectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: MainCollectionViewCell.self, indexPath: indexPath)
        cell.setCell(giftList[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // MEMO: 選択されたセルを元にUIPageViewControllerを配置している画面へデータを引き渡す
        let cell = collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
        self.sectionDelegate?.serveSelectedDataForPresentedViewController(imageView: cell.giftImageView, giftEntity: giftList[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainSectionViewController: UICollectionViewDelegateFlowLayout {

    // セルのサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return MainCollectionViewCell.getCellSize()
    }

    // セルの垂直方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return MainCollectionViewCell.cellMargin
    }

    // セルの水平方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return MainCollectionViewCell.cellMargin
    }

    // セル内のアイテム間の余白(margin)調整を行う
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin = MainCollectionViewCell.cellMargin
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}

// MARK: - StoryboardInstantiatable

extension MainSectionViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "MainSection"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
