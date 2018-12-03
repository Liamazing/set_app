//
//  GameViewController.swift
//  set_app
//
//  Created by Mia Bendy on 12/1/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

//view controller class for the classic set game
class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    var theGame:Set = Set() //has a game
    var timer = Timer() //has a timer
    var refLeaderboard: DatabaseReference! //has a reference to the leaderboard database
    
    @IBOutlet weak var theDisplayedCards: UICollectionView!
    @IBOutlet weak var theNewGameButton: UIButton!
    @IBOutlet weak var numSets: UILabel!
    @IBOutlet weak var displayTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refLeaderboard = Database.database().reference().child("leaderboard")
        theDisplayedCards.register(UINib(nibName: "SingleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "singleCard")
        theDisplayedCards.register(UINib(nibName: "DoubleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "doubleCard")
        theDisplayedCards.register(UINib(nibName: "TripleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "tripleCard")
        theDisplayedCards.dataSource = self
        theDisplayedCards.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //returns number of items in the section as number of cards in the displayed cards array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theGame.displayedCards.count
    }
    
    //at each place in displayed cards makes a view cell for that card
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let theCard:Card = theGame.displayedCards[indexPath.item]
        if theCard.number == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCard", for: indexPath) as! SingleCard
            cell.setCard(card: theCard)
            cell.contentView.layer.borderWidth = 0
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
        cell.contentView.layer.borderColor = UIColor.black.cgColor //set border to black and width to 5 so you know which card you selected
        cell.contentView.layer.borderWidth = 5
        if theGame.selectCard(index: indexPath.item){ //if there were three cards selected
            theDisplayedCards.reloadData() //reload the data, if the cards were a set new cards should appear, if the cards weren't they will become unselected
            numSets.text = "Number of Sets: \(theGame.numSets)" //update number of sets since it may have increased
            if theGame.gameOver(){ //if the game is over
                timer.invalidate() //stop the timer
                let score = theGame.calcScore() //get the score
            
                //pop up an alert so they can enter their score into the leaderboard
                let addNewScore = UIAlertController(title: "Congratulations, your score is \(score)!", message: "Please enter your name", preferredStyle: .alert)
                
                addNewScore.addTextField { (textField) in
                    textField.placeholder = "name"
                }
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    let name:String = (addNewScore.textFields?.first?.text)!
                    self.addLeader(name: name, score: score)
                }
                addNewScore.addAction(okAction)
                present(addNewScore, animated: true, completion: nil)
            }
        }
        
    }
    
    //function to add a score to leaderboard database
    func addLeader(name: String, score: Int){
        let key = refLeaderboard.childByAutoId().key!
        let newScore = ["id":key,
                        "leaderName": name,
                        "leaderScore": score
            ] as [String : Any]
        refLeaderboard.child(key).setValue(newScore)
        print("score added \(name)")
    }
    
    //if new game button was clicked then start a new game
    @IBAction func newGame(_ sender: Any) {
        theGame = Set()
        numSets.text = "Number of Sets: \(theGame.numSets)"
    }
    
    //update the timer
    @objc func updateTimer() {
        theGame.tick()
        displayTime.text = "Time: \(theGame.getTimeString())"
    }


}
