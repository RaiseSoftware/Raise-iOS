//
//  GameDetailsViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 2/20/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class GameDetailsViewController: UIViewController {

    @IBOutlet weak var gameIDLabel: UILabel!
    @IBOutlet weak var passcodeLabel: UILabel!
    @IBOutlet weak var qrCodeButton: UIButton!

    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var playerTableView: UITableView!

    var gameResponse: GameResponse!
    var players = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Socket.shared.connect(token: gameResponse.token.token)

        Socket.shared.playersUpdated = { [weak self] players in
            self?.players = players
            self?.playerTableView.reloadData()
        }

        gameIDLabel.text = "Game ID: \(gameResponse.pokerGame.gameId)"

        if let passcode = gameResponse.pokerGame.passcode {
            passcodeLabel.isHidden = false
            passcodeLabel.text = "Passcode: \(passcode)"
        } else {
            passcodeLabel.isHidden = true
        }

        let base64QRCodeImageComponents = gameResponse.pokerGame.qrcode.components(separatedBy: ",")
        if base64QRCodeImageComponents.count > 1, let imageData = Data(base64Encoded: base64QRCodeImageComponents[1]) {
            qrCodeButton.imageView?.contentMode = .scaleAspectFit
            qrCodeButton.setImage(UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }

    @IBAction func qrCodeTapped() {
        guard let qrCodeImage = qrCodeButton.image(for: .normal) else {
            assertionFailure("Unable to get QR code")
            return
        }

        let activityViewController = UIActivityViewController(activityItems: [qrCodeImage], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}

extension GameDetailsViewController: UIScrollViewDelegate {

    @IBAction func pageControlTapped() {
        let x = CGFloat(pageControl.currentPage) * containerScrollView.frame.size.width
        containerScrollView.setContentOffset(CGPoint(x: x, y: 0.0), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let scrollView = containerScrollView else { return }

        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

extension GameDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlayerTableViewCell.self), for: indexPath) as? PlayerTableViewCell else {
            assertionFailure("Unable to find PlayerTableViewCell")
            return UITableViewCell()
        }

        cell.setUp(with: players[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
}
