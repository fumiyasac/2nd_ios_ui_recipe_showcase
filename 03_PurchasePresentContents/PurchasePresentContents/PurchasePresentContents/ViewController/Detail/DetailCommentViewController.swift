//
//  DetailCommentViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/25.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class DetailCommentViewController: UIViewController {

    // サンプル用のコメントデータを格納するための変数
    private var giftCommentEntityList: [GiftCommentEntity] = [] {
        didSet {
            self.detailCommentTableView.reloadData()
        }
    }

    // GalleryPresenterに設定したプロトコルを適用するための変数
    private var presenter: GiftCommentPresenter!

    @IBOutlet weak private var detailCommentTableView: UITableView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDetailCommentTableView()
        setupGalleryPresenter()
    }

    // MARK: - Private Function

    private func setupDetailCommentTableView() {
        detailCommentTableView.dataSource = self
        detailCommentTableView.estimatedRowHeight = 72.0
        detailCommentTableView.rowHeight = UITableView.automaticDimension
        detailCommentTableView.delaysContentTouches = false
        detailCommentTableView.registerCustomCell(GiftCommentTableViewCell.self)
    }

    private func setupGalleryPresenter() {
        presenter = GiftCommentPresenter(presenter: self)
        presenter.getAllGiftComments()
    }
}

// MARK: - GiftCommentPresenterProtocol

extension DetailCommentViewController: GiftCommentPresenterProtocol {

    func serveGiftCommentList(_ giftComments: [GiftCommentEntity]) {
        giftCommentEntityList = giftComments
    }
}

// MARK: - UITableViewDataSource

extension DetailCommentViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return giftCommentEntityList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: GiftCommentTableViewCell.self)
        cell.setCell(giftCommentEntityList[indexPath.row])
        return cell
    }
}

// MARK: - StoryboardInstantiatable

extension DetailCommentViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Detail"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return DetailCommentViewController.className
    }
}

