//
//  MasonryCollectionViewLayout.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/16.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// 表示する写真の高さをUICollectionViewCellへ反映させるためのプロトコル
protocol MasonryLayoutDelegate: class {

    // 表示対象のセルに対して表示する写真の高さを反映する
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

// UICollectionViewで「Masonry Layout (複数のボックスをタイル状に並べるレイアウト)」を実現するためのクラス
final class MasonryCollectionViewLayout: UICollectionViewLayout {

    weak var delegate: MasonryLayoutDelegate!

    // 並べるカラム数とセル間の隙間の設定
    private let numberOfColumns: Int = 2
    private let paddingCell: CGFloat = 7.5

    // Masonry Layoutを構築するための調整用にUICollectionViewLayoutAttributesを保持する変数
    // MEMO: レイアウトの事前計算時にこの処理を実行する形にする
    private var storedLayoutAttributes: [UICollectionViewLayoutAttributes] = []

    // UICollectionViewにおける中身の高さを保持する変数
    private var collectionViewContentHeight: CGFloat = 0

    // MARK: - Computed Properties

    // UICollectionViewにおける中身の幅を保持する変数
    private var collectionViewContentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0.0
        }
        // MEMO: UICollectionViewにおけるcontentInset値を考慮した幅とする
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    // MARK: - Override

    // UICollectionViewにおける中身のサイズを保持する変数
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewContentWidth, height: collectionViewContentHeight)
    }

    // 原文: UICollectionView Custom Layout Tutorial: Pinterest
    // https://www.raywenderlich.com/392-uicollectionview-custom-layout-tutorial-pinterest
    // 参考1: Pinterest風のUIを作ってみる
    // https://qiita.com/eKushida/items/8f8965467d098ca05120
    // 参考2: UICollectionViewでタグが左寄せに並んでいるようなレイアウトを実現する
    // https://qiita.com/kazuhiro4949/items/03bc3d17d3826aa197c0

    // 一番最初に実行され、全てのレイアウトの事前計算を実行する
    override func prepare() {
        super.prepare()
        
        // 以下の場合については以降の処理を実行しない
        // 1. Layoutを構築するための調整用のLayoutAttribuiteの配列が空の場合
        // 2. UICollectionViewが取得できない場合
        guard storedLayoutAttributes.isEmpty, let collectionView = collectionView else {
            return
        }
        
        // 配置しているセルにおけるX軸方向とY軸方向のオフセット値を配列に別途格納しておく
        let columnWidth = collectionViewContentWidth / CGFloat(numberOfColumns)
        var offsetX = (0..<numberOfColumns).map{ CGFloat($0) * columnWidth }
        var offsetY = [CGFloat](repeating: 0, count: numberOfColumns)
        
        // UICollectionViewにおいて0番目のセクション内の要素に配置されているセル数に応じた更新処理を適用する
        var column = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            // 配置されているセルのIndexPathを取得する
            let indexPath = IndexPath(item: item, section: 0)
            
            // セルの高さを調整して算出するためにセル内に配置されている写真の高さを取得する
            let photoHeight = self.delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            
            // 各UICollectionViewLayoutAttributesに適用するための調整したframe値を算出する
            let fixedHeight = paddingCell * 2 + photoHeight
            let fixedFrame = CGRect(x: offsetX[column], y: offsetY[column], width: columnWidth, height: fixedHeight)
            let insetFrame = fixedFrame.insetBy(dx: paddingCell, dy: paddingCell)
            
            // 各セルに適用するUICollectionViewLayoutAttributesを作成し変数へ格納する
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            storedLayoutAttributes.append(attributes)
            
            // UICollectionViewの高さを調節する
            collectionViewContentHeight = max(collectionViewContentHeight, fixedFrame.maxY)
            offsetY[column] = offsetY[column] + fixedHeight
            
            // ループ処理直前で定義した「変数:column」の値を更新する
            if column < (numberOfColumns - 1) {
                column = column + 1
            } else {
                column = 0
            }
        }
    }

    // 表示領域が変わる場合に実行され、現在表示されている範囲内のセルにおけるUICollectionViewLayoutAttributesを配列で返す
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // 現在表示されているUICollectionViewLayoutAttributesをprepare()での計算処理で調整したものに書き換える
        let visibleLayoutAttributes = storedLayoutAttributes.filter { $0.frame.intersects(rect) }
        return visibleLayoutAttributes
    }

    // セルの要素の追加や削除がされた場合に実行され、影響を受けるセルのUICollectionViewLayoutAttributesを再度計算して返す
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        // 該当するUICollectionViewLayoutAttributesをprepare()での計算処理で調整したものに書き換える
        let targetLayoutAttributes = storedLayoutAttributes[indexPath.item]
        return targetLayoutAttributes
    }

    // 常にレイアウトの再計算を実行するか(※常に再計算を実行する場合はtrueを返す)
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
}
