//
//  HomeViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 3/3/19.
//  Copyright © 2019 Raise Software. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private var scrollView: ExtendedScrollView!
    @IBOutlet private var createButton: RoundedFilledButton!
    @IBOutlet private var joinButton: RoundedFilledButton!
    @IBOutlet private var offlineButton: RoundedFilledButton!
    @IBOutlet private var modeLabel: UILabel!

    @IBOutlet private var createContainerView: UIView!
    @IBOutlet private var joinContainerView: UIView!
    @IBOutlet private var offlineContainerView: UIView!

    @IBOutlet private var tapAreas: [UIButton]!

    private var createViewController: CreateViewController?
    private var joinViewController: JoinViewController?
    private var offlineViewController: OfflineViewController?

    @IBOutlet var scrollViewFullScreenConstraints: [NSLayoutConstraint]!
    @IBOutlet var scrollViewMinimizedConstraints: [NSLayoutConstraint]!

    enum Mode: Int {
        case create, join, offline

        var title: String {
            switch self {
            case .create:
                return "Create Game"
            case .join:
                return "Join Game"
            case .offline:
                return "Offline Game"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        [createViewController, joinViewController, offlineViewController].forEach {
            $0?.delegate = self
            $0?.view.clipsToBounds = true
            $0?.view.layer.cornerRadius = 10
            $0?.updateCloseButtonVisibility(alpha: 0)
        }

        setModeSelected(.create)
        updateViewScaling()
    }

    @IBAction private func tapAreaPressed(sender: UIButton) {
        if let mode = Mode(rawValue: sender.tag) {
            showViewFullScreen(mode)
        }
    }

    private func showViewFullScreen(_ mode: Mode) {
        let offset: CGPoint
        let controller: HomeItemViewController?
        switch mode {
        case .create:
            offset = .zero
            controller = createViewController
        case .join:
            offset = CGPoint(x: view.frame.width + 10, y: 0)
            controller = joinViewController
        case .offline:
            offset = CGPoint(x: (view.frame.width + 10) * 2, y: 0)
            controller = offlineViewController
        }

        tapAreas.forEach { $0.isHidden = true }
        scrollView.isScrollEnabled = false

        UIView.animate(withDuration: 0.5, animations: {
            NSLayoutConstraint.deactivate(self.scrollViewMinimizedConstraints)
            NSLayoutConstraint.activate(self.scrollViewFullScreenConstraints)

            controller?.view.layer.cornerRadius = 0
            controller?.updateCloseButtonVisibility(alpha: 1)

            self.view.layoutIfNeeded()
            self.scrollView.contentOffset = offset
        }, completion: { _ in
            controller?.view.isUserInteractionEnabled = true
        })
    }

    @IBAction private func actionButtonPressed(sender: UIButton) {
        if let mode = Mode(rawValue: sender.tag) {
            scrollView.scrollToPage(page: mode.rawValue)
        }
    }

    private func setModeSelected(_ mode: Mode) {
        modeLabel.text = mode.title

        createButton.isSelected = mode == .create
        joinButton.isSelected = mode == .join
        offlineButton.isSelected = mode == .offline
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let createVC = segue.destination as? CreateViewController {
            createViewController = createVC
        } else if let joinVC = segue.destination as? JoinViewController {
            joinViewController = joinVC
        } else if let offlineVC = segue.destination as? OfflineViewController {
            offlineViewController = offlineVC
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateViewScaling()

        let width = scrollView.frame.size.width
        let page = Int((scrollView.contentOffset.x + (0.5 * width)) / width)

        let mode: Mode
        switch page {
        case 1:
            mode = .join
        case 2:
            mode = .offline
        default:
            mode = .create
        }

        setModeSelected(mode)
    }

    private func updateViewScaling() {
        let width = scrollView.frame.size.width
        let power: CGFloat = 0.05
        let minScale: CGFloat = 0.9

        let createViewClosenessToCenter = min(max(1 - scrollView.contentOffset.x / width, 0), 1)
        let joinViewClosenessToCenter = min(max(1 - abs(width - scrollView.contentOffset.x) / width, 0), 1)
        let offlineViewClosenessToCenter = min(max(1 - abs((width * 2) - scrollView.contentOffset.x) / width, 0), 1)

        createContainerView.transform = CGAffineTransform(scaleX: 1, y: max(minScale, pow(createViewClosenessToCenter, power)))
        joinContainerView.transform = CGAffineTransform(scaleX: 1, y: max(minScale, pow(joinViewClosenessToCenter, power)))
        offlineContainerView.transform = CGAffineTransform(scaleX: 1, y: max(minScale, pow(offlineViewClosenessToCenter, power)))
    }
}

extension HomeViewController: HomeItemDelegate {

    func closePressed(_ controller: HomeItemViewController) {
        let offset: CGPoint
        if controller is CreateViewController {
            offset = .zero
        } else if controller is JoinViewController {
            offset = CGPoint(x: view.frame.width - 40, y: 0)
        } else {
            offset = CGPoint(x: (view.frame.width - 40) * 2, y: 0)
        }

        controller.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            NSLayoutConstraint.deactivate(self.scrollViewFullScreenConstraints)
            NSLayoutConstraint.activate(self.scrollViewMinimizedConstraints)

            controller.view.layer.cornerRadius = 10
            controller.updateCloseButtonVisibility(alpha: 0)
            self.view.layoutIfNeeded()
            self.scrollView.contentOffset = offset
        }, completion: { _ in
            self.tapAreas.forEach { $0.isHidden = false }
            self.scrollView.isScrollEnabled = true
        })
    }
}
