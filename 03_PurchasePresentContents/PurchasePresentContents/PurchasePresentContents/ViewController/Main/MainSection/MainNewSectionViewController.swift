//
//  MainNewSectionViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class MainNewSectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - StoryboardInstantiatable

extension MainNewSectionViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "MainSection"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return MainNewSectionViewController.className
    }
}
