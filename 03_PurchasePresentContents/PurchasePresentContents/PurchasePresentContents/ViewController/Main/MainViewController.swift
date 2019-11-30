//
//  MainViewController.swift
//  PurchasePresentContents
//
//  Created by 酒井文也 on 2019/02/10.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import PinterestSegment
import DeckTransition
import ARNTransitionAnimator

final class MainViewController: ZoomImageTransitionViewController {

    // 写真が拡大するようなアニメーションを実現する際に必要な変数
    private var selectedImageView: UIImageView!
    private var transionAnimator: ARNTransitionAnimator!

    // ボタン押下時の軽微な振動(Haptic Feedback)を追加する
    private let feedbackGenerator: UIImpactFeedbackGenerator = {
        let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        return generator
    }()

    // ページングして表示させるViewControllerを保持する配列
    private var targetViewControllerLists: [UIViewController] = []

    // ContainerViewにEmbedしたUIPageViewControllerのインスタンスを保持する
    private var pageViewController: UIPageViewController?

    // 現在UIPageViewControllerで表示しているViewControllerのインデックス番号
    private var currentIndex: Int = 0
    
    @IBOutlet weak private var lineupSegmentControl: PinterestSegment!
    @IBOutlet weak private var sectionContainerView: UIView!
    @IBOutlet weak private var informationButtonView: InformationButtonView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle("PRESENT SHOP")
        setupLineupSegmentControl()
        setupPageViewController()
        setupInformationButtonView()
    }

    override func createTransitionImageView() -> UIImageView {
        let imageView = UIImageView(image: selectedImageView.image)
        imageView.contentMode = selectedImageView!.contentMode
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.frame = selectedImageView.convert(selectedImageView.frame, to: self.navigationController?.view)
        return imageView
    }

    // MARK: - Private Function

    private func setupLineupSegmentControl() {

        // PinterestSegmentのスタイルを設定する
        var segmentStyle = PinterestSegmentStyle()
        segmentStyle.indicatorColor = UIColor(code: "#ffae00")
        segmentStyle.titlePendingHorizontal = 16
        segmentStyle.titlePendingVertical = 16
        segmentStyle.titleFont = UIFont(name: "HiraKakuProN-W6", size: 13.0)!
        segmentStyle.normalTitleColor = .lightGray
        segmentStyle.selectedTitleColor = .white
        lineupSegmentControl.style = segmentStyle

        // PinterestSegmentのタイトルを設定する
        lineupSegmentControl.titles = MainSectionType.allCases.map{
            $0.getTitle()
        }

        // PinterestSegmentのタップ時のアクションを設定する
        lineupSegmentControl.valueChange = { targetIndex in

            // MEMO: 現在のIndex値と切り替え対象のIndex値の差分で動きを決定する
            let diff = self.currentIndex - targetIndex
            if diff > 0 {
                self.moveToPageViewControllerFor(targetIndex: targetIndex, targetDirection: .reverse)
            } else if diff < 0 {
                self.moveToPageViewControllerFor(targetIndex: targetIndex, targetDirection: .forward)
            }
            self.currentIndex = targetIndex

            // Haptic Feedbackを発火させる
            self.feedbackGenerator.impactOccurred()
        }
    }

    // UIPageViewControllerの設定
    private func setupPageViewController() {

        // UIPageViewControllerで表示したいViewControllerの一覧を取得する
        let _ = MainSectionType.allCases.map{
            let targetViewController = $0.getViewController()

            // MEMO: tag値をMainSectionTypeと対応させる
            targetViewController.view.tag = $0.rawValue

            // MEMO: 生成したViewControllerで定義しているデータ取得処理を実行する
            targetViewController.executeGetGiftListBy(mainSectionType: $0)

            // MEMO: MainSectionViewControllerで定義したプロトコルを適用する
            targetViewController.sectionDelegate = self
            targetViewControllerLists.append(targetViewController)
        }

        // ContainerViewと接続しているUIPageViewControllerを取得する
        for childViewController in children {
            if let targetPageViewController = childViewController as? UIPageViewController {
                pageViewController = targetPageViewController
            }
        }

        // UIPageViewControllerにおける初期設定をする
        if let targetPageViewController = pageViewController {

            // MEMO: Storyboardを利用する場合はTransitionStyleはInterfaceBuilderで設定する
            // UIPageViewControllerDelegate & UIPageViewControllerDataSourceの宣言
            targetPageViewController.delegate = self
            targetPageViewController.dataSource = self

            // 最初に表示する画面として配列の先頭のViewControllerを設定する
            targetPageViewController.setViewControllers([targetViewControllerLists[0]], direction: .forward, animated: false, completion: nil)
        }
    }

    // 該当のIndex値と動かす方向に合わせて表示対象のUIViewControllerを表示させる
    private func moveToPageViewControllerFor(targetIndex: Int, targetDirection: UIPageViewController.NavigationDirection) {
        if let targetPageViewController = pageViewController {
            targetPageViewController.setViewControllers([targetViewControllerLists[targetIndex]], direction: targetDirection, animated: true, completion: nil)
        }
    }

    // お知らせ表示ボタンが押下された際にはDeckTransitionを利用した表示をさせる
    private func setupInformationButtonView() {
        informationButtonView.showInformationButtonAction = {

            // ライブラリ「DeckTransition」を利用したメッセージアプリの様な画面遷移を行う
            // MEMO: iOS13以降のPresent/Dismiss時は.modalPresentationStyleの設定がない場合はこのライブラリとほとんど同じ挙動になる
            let vc = MainInformationViewController.instantiate()
            let delegate = DeckTransitioningDelegate()
            vc.transitioningDelegate = delegate
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: - MainSectionDelegate

extension MainViewController: MainSectionDelegate {

    // UIImageViewをプロトコル適用先の画面へ引き渡す
    func serveSelectedDataForPresentedViewController(imageView: UIImageView, giftEntity: GiftEntity) {

        // 遷移先のViewControllerを作成しUIPageViewControllerで選択されたUIImageViewとGiftEntityを反映する
        let vc = DetailGiftViewController.instantiate()
        vc.setEntityFromPresentingViewController(giftEntity)

        // カスタムトランジションを実行するためのクラスを作成する
        let zoomImageTransition = ZoomImageTransition<ZoomImageTransitionViewController>(rootVC: self, modalVC: vc, rootNavigation: self.navigationController)
        let zoomImageAnimator = ARNTransitionAnimator(duration: 0.28, animation: zoomImageTransition)

        // 遷移先のViewControllerを作成する
        vc.transitioningDelegate = zoomImageAnimator

        // 必要な値をアニメーションを実現する際に必要な変数へセットする
        transionAnimator = zoomImageAnimator
        selectedImageView = imageView

        // Modalの画面遷移を実行する
        // MEMO: iOS13以降のPresent/Dismiss時の調整
        // Present/Dismissで実行するカスタムトランジションの場合ではこの設定を忘れると画面遷移がおかしくなるので注意
        if #available(iOS 13.0, *) {
            vc.modalPresentationStyle = .fullScreen
        }
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension MainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    // スワイプアニメーションでページが動いたタイミングで実行される
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        // スワイプアニメーションが完了していない場合は以降の処理を実行しない
        if !completed {
            return
        }

        // ここから先はUIPageViewControllerのスワイプアニメーション完了時に発動する
        if let targetViewControllers = pageViewController.viewControllers {
            if let targetViewController = targetViewControllers.last {

                // 受け取ったインデックス値を元にコンテンツ表示を更新する
                currentIndex = targetViewController.view.tag
                lineupSegmentControl.setSelectIndex(index: currentIndex, animated: true)

                // Haptic Feedbackを発火させる
                feedbackGenerator.impactOccurred()
            }
        }
    }

    // 逆方向にページ送りしたタイミングで実行される
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        // インデックスを取得してその値に応じてコンテンツを移動する
        guard let index = targetViewControllerLists.firstIndex(of: viewController) else {
            return nil
        }

        if index <= 0 {
            return nil
        }

        return targetViewControllerLists[index - 1]
    }

    // 順方向にページ送りしたタイミングで実行される
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        // インデックスを取得してその値に応じてコンテンツを移動する
        guard let index = targetViewControllerLists.firstIndex(of: viewController) else {
            return nil
        }

        if index >= targetViewControllerLists.count - 1 {
            return nil
        }
        
        return targetViewControllerLists[index + 1]
    }
}
