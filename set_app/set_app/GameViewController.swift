//
//  GameViewController.swift
//  set_app
//
//  Created by Mia Bendy on 12/1/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var theGame:Set = Set()
    var timer = Timer()
    
    @IBOutlet weak var cardsLeft: UILabel!
    @IBOutlet weak var theDisplayedCards: UICollectionView!
    @IBOutlet weak var theNewGameButton: UIButton!
    @IBOutlet weak var numSets: UILabel!
    @IBOutlet weak var displayTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theDisplayedCards.register(UINib(nibName: "SingleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "singleCard")
        theDisplayedCards.register(UINib(nibName: "DoubleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "doubleCard")
        theDisplayedCards.register(UINib(nibName: "TripleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "tripleCard")
        theDisplayedCards.dataSource = self
        theDisplayedCards.delegate = self
        cardsLeft.text = "\(theGame.deck.count())"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
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
            let cellBGView = UIView()
            cellBGView.backgroundColor = UIColor.blue
            cell.selectedBackgroundView? = cellBGView
            cell.setCard(card: theCard)
            return cell
            
        }
        else if theCard.number == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doubleCard", for: indexPath) as! DoubleCard
            let cellBGView = UIView()
            cellBGView.backgroundColor = UIColor.blue
            cell.selectedBackgroundView? = cellBGView
            cell.setCard(card: theCard)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tripleCard", for: indexPath) as! TripleCard
            let cellBGView = UIView()
            cellBGView.backgroundColor = UIColor.blue
            cell.selectedBackgroundView? = cellBGView
            cell.setCard(card: theCard)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected card" )
        if theGame.selectCard(index: indexPath.item){
            cardsLeft.text = "\(theGame.deck.count())"
            theDisplayedCards.reloadData()
            numSets.text = "Number of Sets: \(theGame.numSets)"
            if theGame.gameOver(){
                print("Game Over")
                timer.invalidate()
            }
        }
        
    }
    
    @objc func updateTimer() {
        theGame.tick()
        displayTime.text = "Time: \(theGame.getTimeString())"
    }
    
    /*func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselected card")
        theGame.deselectCard(index: indexPath.item)
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
