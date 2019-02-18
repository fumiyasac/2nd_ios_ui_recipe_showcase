//
//  PhotoGalleryPresenter.swift
//  TypicalAnimationContents
//
//  Created by 酒井文也 on 2019/02/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation

// 引数で渡された写真一覧をもとに画面表示処理を実行する
// → 該当ViewControllerへの橋渡し役
protocol PhotoGalleryPresenterDelegate: NSObjectProtocol {
    func setPhotosToScreen(_ photos: [PhotoGalleryModel])
}

final class PhotoGalleryPresenter {

    weak var delegate: PhotoGalleryPresenterDelegate?

    private let photoGalleryModels: [PhotoGalleryModel]

    // MARK: - Initializer

    init() {
        if let path = Bundle.main.path(forResource: "photo_gallery_datasource", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            self.photoGalleryModels = try! JSONDecoder().decode([PhotoGalleryModel].self, from: data)
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }

    // MARK: - Function

    func getPhotoList() {
        self.delegate?.setPhotosToScreen(photoGalleryModels)
    }
}
