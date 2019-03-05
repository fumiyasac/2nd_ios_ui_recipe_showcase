//
//  MainSliderViewController.swift
//  MediaStyleAnimationContents
//
//  Created by 酒井文也 on 2019/02/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import FSPagerView
import AlamofireImage

final class MainSliderViewController: UIViewController {

    private var mainSliderLists: [MainSliderEntity] = [] {
        didSet {
            self.mainSliderView.reloadData()
        }
    }

    @IBOutlet weak private var mainSliderView: FSPagerView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSliderView()
    }

    // MARK: - Private Function

    private func setupSliderView() {
        mainSliderView.delegate = self
        mainSliderView.dataSource = self
        mainSliderView.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 180)
        mainSliderView.interitemSpacing = 16
        mainSliderView.transformer = FSPagerViewTransformer(type: .depth)
    }
}

// MARK: - FSPagerViewDataSource, FSPagerViewDelegate

extension MainSliderViewController: FSPagerViewDataSource, FSPagerViewDelegate {

    // MEMO: UICollectionViewの配置対象のセクションの個数を設定する部分に相当
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return mainSliderLists.count
    }

    // MEMO: UICollectionViewの配置対象のセクションに配置するセルの個数を設定する部分に相当する
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {

        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)

        let mainSlider = mainSliderLists[index]
        if let imageUrl = mainSlider.imageUrl {
            cell.imageView?.af_setImage(withURL: imageUrl)
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
        }
        cell.textLabel?.text = mainSlider.title
        cell.contentView.layer.shadowOpacity = 0.4
        cell.contentView.layer.opacity = 0.86

        return cell
    }

    // MEMO: UICollectionViewの配置対象のセクション押下時の処理を設定する部分に相当する
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
}
