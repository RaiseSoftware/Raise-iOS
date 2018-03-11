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

    @IBOutlet weak var playerTableView: UITableView!

    var players = [Player]()
    var pokerGame: PokerGame!
    var cardImages = [UIImage]()
    var selectedCardIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        if pokerGame.deckType == .fibonacci {
            cardImages = [#imageLiteral(resourceName: "Card-0"), #imageLiteral(resourceName: "Card-Half"), #imageLiteral(resourceName: "Card-1"), #imageLiteral(resourceName: "Card-2"), #imageLiteral(resourceName: "Card-3"), #imageLiteral(resourceName: "Card-5"), #imageLiteral(resourceName: "Card-8"), #imageLiteral(resourceName: "Card-13"), #imageLiteral(resourceName: "Card-20"), #imageLiteral(resourceName: "Card-40"), #imageLiteral(resourceName: "Card-100"), #imageLiteral(resourceName: "Card-Infinity"), #imageLiteral(resourceName: "Card-Question"), #imageLiteral(resourceName: "Card-Coffee")]
        } else {
            cardImages = [#imageLiteral(resourceName: "Card-Question"), #imageLiteral(resourceName: "Card-Coffee")]
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PokerPlayerTableViewCell.self), for: indexPath) as? PokerPlayerTableViewCell else {
            assertionFailure("Unable to find PokerPlayerTableViewCell")
            return UITableViewCell()
        }

        cell.setUp(with: players[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
}

extension PokerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CardCollectionViewCell.self), for: indexPath) as? CardCollectionViewCell else {
            assertionFailure("Unable to find CardCollectionViewCell")
            return UICollectionViewCell()
        }

        cell.cardImageView.image = cardImages[indexPath.item]
        cell.cardImageView.alpha = selectedCardIndex == indexPath.item ? 0.5 : 1.0

        return cell
    }
}

extension PokerViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = cardImages[indexPath.item]
        selectedImageView.image = image
        selectedCardIndex = indexPath.item
        collectionView.reloadData()
    }
}
