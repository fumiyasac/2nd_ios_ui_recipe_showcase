# iOSアプリ開発 - UI実装であると嬉しいレシピブックVol.2に掲載するサンプル

## 1. 概要

こちらは、上記書籍にて紹介しているサンプルを収録したリポジトリになります。書籍内で解説の際に利用したサンプルコードの完成版のプロジェクトがそれぞれの章毎にありますので、書籍内の解説をより詳細に理解する際や開発中のアプリにおける実装時の参考等にご活用頂ければ嬉しく思います。

 * macOS Catalina 10.15.1
 * Xcode 11.1
 * Swift 5.1
 * CocoaPods 1.8.4

※ サンプルで利用しているライブラリの中にはSwift4.2のまま利用しているものがあります。

趣旨としましては、UIライブラリを導入したサンプル実装の解説を通じて「このライブラリを活用することで享受できるメリットはどの部分か？」「類似UIを自前で実装する際に押さえておくべきポイントとなりうるのはどの部分か？」という点に着目し、実際のアプリ開発におけるUI実装への布石なるような実践事例を3点収録しています。

__書籍における現在の進捗とロードマップ:__

電子書籍版v1.0公開は2019年5月下旬を予定しております。

__プロジェクトを動作させるための事前準備:__

サンプルコードでは、ライブラリの管理ツールでCocoaPodsを利用しております。CocoaPodsのインストール方法や基本的な活用方法につきましては下記のリンク等を参考にすると良いかと思います。

+ [初心者向けCocoaPodsの使い方](http://developers.goalist.co.jp/entry/2017/04/20/180931)
+ [CocoaPodsの使い方-入門編](https://www.ukeyslabo.com/development/iosapplication/how-to-use-cocoapods-for-beginner/)
+ [CocoaPodsのPodfileの書き方](https://dev.digitrick.us/notes/podfilesyntax)

## 2. サンプル図解

こちらはの書籍で紹介しているサンプルにおける概略図になります。

### ⭐️第1章サンプル

本章ではTabBarControllerでの画面切り替え時のアニメーション表現と表示コンテンツにおけるレイアウトのカスタマイズと表現方法に関するTipsについて解説をしていきます。TabBarControllerを切り替える場合に実行するアニメーション表現についてはUI実装ライブラリを活用する一方で、表示コンテンツにおけるUIレイアウトや表示に関する部分については自前で実装する形としています。

![第1章サンプル図](https://github.com/fumiyasac/2nd_ios_ui_recipe_showcase/blob/master/images/capture_techbook_vol2_chapter1.jpg)

__利用しているライブラリ一覧:__

```ruby
target 'TypicalAnimationContents' do
  use_frameworks!
  pod 'FontAwesome.swift'
  pod 'TransitionableTab', '~> 0.2.0'
end

# TransitionableTabのライブラリバージョンをSwift4.2に固定する
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['TransitionableTab'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end
```

__ライブラリのインストール手順:__

```shell
# 今回利用するライブラリのインストール手順
$ cd 01_TypicalAnimationContents/TypicalAnimationContents/ 
$ pod install
```

### ️⭐️第2章サンプル

本章ではニュースや読み物系のアプリの中で良く見かけるレイアウトにおけるUI実装において、ベースとなる部分以外のUI表現におけるワンポイントとなる部分にUIライブラリを活用した表現を実装するためのTipsと、API通信による非同期通信処理を実行する部分についてよく利用されているライブラリを活用した実装をするためのTipの2点について解説をしてきます。

![第2章サンプル図](https://github.com/fumiyasac/2nd_ios_ui_recipe_showcase/blob/master/images/capture_techbook_vol2_chapter2.jpg)

__利用しているライブラリ一覧:__

```ruby
target 'MediaStyleAnimationContents' do
  use_frameworks!
  pod 'SwiftyJSON'
  pod 'Alamofire'
  pod 'PromiseKit'
  pod 'AlamofireImage'
  pod 'FontAwesome.swift'
  pod 'ActiveLabel'
  pod 'Floaty'
  pod 'FSPagerView'
  pod 'SVProgressHUD'
  pod 'BTNavigationDropdownMenu'
  pod 'Toast-Swift', '~> 5.0.0'
end

# BTNavigationDropdownMenuのライブラリバージョンをSwift4.2に固定する
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['BTNavigationDropdownMenu'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end
```

__ライブラリのインストール手順:__

```shell
# 今回利用するライブラリのインストール手順
$ cd 02_MediaStyleAnimationContents/MediaStyleAnimationContents/ 
$ pod install
```

__APIモックサーバーの準備手順:__

本章のサンプルではサンプルアプリ内にAPIモックサーバーから受け取ったJSON形式のレスポンスを画面に表示する処理を実現するために、Node.js製の「JSONServer」というものを利用して実現しています。JSONServerに関する概要や基本的な活用方法につきましては下記のリンク等を参考にすると良いかと思います。

+ [たった30秒でRESTAPIのモックが作れるJSONServerでフロントエンド開発が捗る](https://www.webprofessional.jp/mock-rest-apis-using-json-server/)

```shell
# 1. 必要なパッケージのインストールを実行する
$ cd 02_MediaStyleAnimationContents/server_mock/ 
$ npm install
# 2. モックAPIサーバを起動する(http://localhost:3000/)
$ node index.js
```

### ⭐️第3章サンプル

本章ではECやメディア系のアプリにおいてよく目にするタイプの表現でもある、写真を生かした画面レイアウトや心地よいアニメーションを組み合わせたUI表現においてUIライブラリを積極的に活用したレイアウトのカスタマイズとアニメーション表現に関するTipsについて解説をしていきます。このサンプルで紹介している表現については、綺麗なUI表現をセールスポイントにしているアプリにおいては試してみたいと思える表現ではあるが、正攻法で挑むと工数も手間も想像以上に掛かるUI表現に関する実装をライブラリが持っている特性や実装方法を上手に活用しながらUI表現を組み立てるための実装について解説をしていきます。

![第3章サンプル図](https://github.com/fumiyasac/2nd_ios_ui_recipe_showcase/blob/master/images/capture_techbook_vol2_chapter3.jpg)

__利用しているライブラリ一覧:__

```ruby
target 'PurchasePresentContents' do
  use_frameworks!
  pod 'PINRemoteImage', '3.0.0-beta.14'
  pod 'FontAwesome.swift'
  pod 'Cosmos'
  pod 'DeckTransition'
  pod 'AnimatedCollectionViewLayout'
  pod 'PinterestSegment'
  pod 'ARNTransitionAnimator'
  pod 'FloatingPanel'
  pod 'SkeletonView'
end

# PinterestSegmentのライブラリバージョンをSwift4.2に固定する
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['PinterestSegment'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end
```

__ライブラリのインストール手順:__

```shell
# 今回利用するライブラリのインストール手順
$ cd 03_PurchasePresentContents/PurchasePresentContents/ 
$ pod install
```

## 3. その他サンプルに関することについて

その他、サンプルにおける気になる点や要望等がある場合は是非GithubのIssueやPullRequestをお送り頂けますと嬉しく思います。

__【iOS13 & Xcode11.1へのバージョンアップにおいてこのサンプルで触れていない部分】__

本サンプルでは下記の部分に関しては、今回は対応していませんのでご注意下さい。

+ DarkModeの無効化（現在は強制的にLightModeにしています。）
+ SceneDelegateは利用しない従来のAppDelegateの利用（現状は挙動に問題はありませんが非推奨です。）
