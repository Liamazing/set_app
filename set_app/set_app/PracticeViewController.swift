//
//  PracticeViewController.swift
//  set_app
//
//  Created by Mia Bendy on 12/1/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import UIKit

//view controller for practice/infinite mode
class PracticeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var theGame:InfiniteSet = InfiniteSet() //has a game of infinite set
    
    @IBOutlet weak var numSets: UILabel!
    @IBOutlet weak var theDisplayedCards: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theDisplayedCards.register(UINib(nibName: "SingleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "singleCard")
        theDisplayedCards.register(UINib(nibName: "DoubleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "doubleCard")
        theDisplayedCards.register(UINib(nibName: "TripleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "tripleCard")
        theDisplayedCards.dataSource = self
        theDisplayedCards.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //returns number of cards in the displayed cards array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theGame.displayedCards.count
    }
    
    //at each place in displayed cards makes a view cell for that card
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let theCard:Card = theGame.displayedCards[indexPath.item]
        if theCard.number == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCard", for: indexPath) as! SingleCard
            cell.contentView.layer.borderWidth = 0
            cell.setCard(card: theCard)
            return cell
            
        }
        else if theCard.number == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doubleCard", for: indexPath) as! DoubleCard
            cell.contentView.layer.borderWidth = 0
            cell.setCard(card: theCard)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tripleCard", for: indexPath) as! TripleCard
            cell.contentView.layer.borderWidth = 0
            cell.setCard(card: theCard)
            return cell
        }
    }
    
    //for when a card is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = theDisplayedCards.cellForItem(at: indexPath)!
        cell.contentView.layer.borderColor = UIColor.black.cgColor //update border color and width to show user has selected that card
        cell.contentView.layer.borderWidth = 5
        if theGame.selectCard(index: indexPath.item){ //if the player has selected three cards
            theDisplayedCards.reloadData() //reload the data as a set may have disappeared, or the cards should become unselected (border disappears)
            numSets.text = "Number of Sets: \(theGame.numSets)" //update number of sets found
        }
    }


}
