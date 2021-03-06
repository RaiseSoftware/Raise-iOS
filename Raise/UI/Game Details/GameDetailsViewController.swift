//
//  GameDetailsViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 2/20/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class GameDetailsViewController: UIViewController {

    @IBOutlet private var gameIDLabel: UILabel!
    @IBOutlet private var passcodeLabel: UILabel!
    @IBOutlet private var qrCodeButton: UIButton!

    @IBOutlet private var containerScrollView: UIScrollView!
    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var playerTableView: UITableView!

    @IBOutlet private var startGameButton: UIButton!

    var game: PokerGame!
    var players = [Player]() {
        didSet {
            startGameButton.isEnabled = players.count > 0
            playerTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSocket()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(exitGamePressed))

//        gameIDLabel.text = "Game ID: \(gameResponse.pokerGame.gameId)"

//        if let passcode = gameResponse.pokerGame.passcode, !passcode.isEmpty {
//            passcodeLabel.isHidden = false
            passcodeLabel.text = "Passcode: \(game.passcode)"
//        } else {
//            passcodeLabel.isHidden = true
//        }

        let base64QRCodeImageComponents = game.qrcode.components(separatedBy: ",")
        if base64QRCodeImageComponents.count > 1, let imageData = Data(base64Encoded: base64QRCodeImageComponents[1]) {
            qrCodeButton.imageView?.contentMode = .scaleAspectFit
            qrCodeButton.setImage(UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }

    func configureSocket() {
//        Socket.shared.connect(token: gameResponse.token.token)

        Socket.shared.playersUpdated = { [weak self] players in
            self?.players = players
        }

        Socket.shared.startGame = { [weak self] in
            self?.performSegue(withIdentifier: "startGame", sender: nil)
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

    @IBAction func startGameButtonPressed() {
        Socket.shared.send(.startGame)
    }

    @objc func exitGamePressed() {
        presentConfirmationAlert(title: "Exit Poker Game", message: "Are you sure you want to exit this game?") { [weak self] _ in
            Socket.shared.disconnect()
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokerViewController = segue.destination as? PokerViewController {
            pokerViewController.deck = game.deckType
        }
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
