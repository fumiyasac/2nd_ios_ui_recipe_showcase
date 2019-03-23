//
//  MainInformationViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/03/23.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class MainInformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - StoryboardInstantiatable

extension MainInformationViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "MainInformation"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
