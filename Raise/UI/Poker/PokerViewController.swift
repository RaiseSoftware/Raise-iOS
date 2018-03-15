//
//  PokerViewController.swift
//  Raise
//
//  Created by Stephen Hayes on 3/4/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import UIKit

class PokerViewController: UIViewController {

    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var selectedImageView: UIImageView!

    @IBOutlet weak var activeCardTableView: UITableView!

    var activeCards = [ActiveCard]() {
        didSet {
            activeCardTableView.reloadData()
        }
    }

    var pokerGame: PokerGame!
    var cards = [Card]()
    var selectedCardIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        cards = pokerGame.deckType.cards

        Socket.shared.activeCardsUpdated = { [weak self] activeCards in
            self?.activeCards = activeCards
        }
    }
}

extension PokerViewController: UIScrollViewDelegate {

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

extension PokerViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActiveCardTableViewCell.self), for: indexPath) as? ActiveCardTableViewCell else {
            assertionFailure("Unable to find PokerPlayerTableViewCell")
            return UITableViewCell()
        }

        cell.setUp(with: activeCards[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeCards.count
    }
}

extension PokerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CardCollectionViewCell.self), for: indexPath) as? CardCollectionViewCell else {
            assertionFailure("Unable to find CardCollectionViewCell")
            return UICollectionViewCell()
        }

        cell.cardImageView.image = cards[indexPath.item].value.image
        cell.cardImageView.alpha = selectedCardIndex == indexPath.item ? 0.5 : 1.0

        return cell
    }
}

extension PokerViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = cards[indexPath.item]
        selectedImageView.image = card.value.image

        if selectedCardIndex != indexPath.item {
            selectedCardIndex = indexPath.item

            let cardSubmitRequest = CardSubmitRequest(type: pokerGame.deckType, value: card.value)
            Socket.shared.send(.cardSubmit, data: cardSubmitRequest)
            collectionView.reloadData()
        }
    }
}
