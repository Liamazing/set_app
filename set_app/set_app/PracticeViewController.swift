//
//  PracticeViewController.swift
//  set_app
//
//  Created by Mia Bendy on 12/1/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    

    var theGame:InfiniteSet = InfiniteSet()
    
    @IBOutlet weak var numSets: UILabel!
    @IBOutlet weak var theDisplayedCards: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theDisplayedCards.register(UINib(nibName: "SingleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "singleCard")
        theDisplayedCards.register(UINib(nibName: "DoubleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "doubleCard")
        theDisplayedCards.register(UINib(nibName: "TripleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "tripleCard")
        theDisplayedCards.dataSource = self
        theDisplayedCards.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theGame.displayedCards.count
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = theDisplayedCards.cellForItem(at: indexPath)!
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 5
        if theGame.selectCard(index: indexPath.item){
            theDisplayedCards.reloadData()
            numSets.text = "Number of Sets: \(theGame.numSets)"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
