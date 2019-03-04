//
//  HomeViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 3/3/19.
//  Copyright © 2019 Raise Software. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var createButton: RoundedFilledButton!
    @IBOutlet private var joinButton: RoundedFilledButton!
    @IBOutlet private var offlineButton: RoundedFilledButton!
    @IBOutlet private var modeLabel: UILabel!

    private var createViewController: CreateViewController?
    private var joinViewController: JoinViewController?
    private var offlineViewController: OfflineViewController?

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
            $0?.view.isUserInteractionEnabled = false
            $0?.view.clipsToBounds = true
            $0?.view.layer.cornerRadius = 10.0
        }

        setModeSelected(.create)
    }

    @IBAction private func createButtonPressed() {
        scrollView.scrollToPage(page: Mode.create.rawValue)
    }

    @IBAction private func joinButtonPressed() {
        scrollView.scrollToPage(page: Mode.join.rawValue)
    }

    @IBAction private func offlineButtonPressed() {
        scrollView.scrollToPage(page: Mode.offline.rawValue)
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
}
