//
//  AppDelegate.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/02/10.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

// 本サンプルにおいて現状非対応にしている、または最低限の対応だけに留めている部分は下記の通り
// 1. DarkMode: 現状ではDarkModeをキャンセルしています。
// 2. UISceneAPI: 現状挙動への問題はないがiOS13以降では非推奨となっています。

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // MEMO: DarkModeのキャンセル（Info.plistについても念のため記載）
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}

