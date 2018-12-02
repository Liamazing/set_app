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

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var theGame:Set = Set()
    var timer = Timer()
    var refLeaderboard: DatabaseReference!
    
    @IBOutlet weak var theDisplayedCards: UICollectionView!
    @IBOutlet weak var theNewGameButton: UIButton!
    @IBOutlet weak var numSets: UILabel!
    @IBOutlet weak var displayTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        refLeaderboard = Database.database().reference().child("leaderboard")
        theDisplayedCards.register(UINib(nibName: "SingleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "singleCard")
        theDisplayedCards.register(UINib(nibName: "DoubleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "doubleCard")
        theDisplayedCards.register(UINib(nibName: "TripleCardCollectionView", bundle: nil), forCellWithReuseIdentifier: "tripleCard")
        theDisplayedCards.dataSource = self
        theDisplayedCards.delegate = self
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
            cell.setCard(card: theCard)
            //cell.contentView.layer.borderColor = UIColor.black.cgColor
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected card" )
        let cell = theDisplayedCards.cellForItem(at: indexPath)!
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 5
        if theGame.selectCard(index: indexPath.item){
            theDisplayedCards.reloadData()
            numSets.text = "Number of Sets: \(theGame.numSets)"
            if theGame.gameOver(){
                print("Game Over")
                timer.invalidate()
                let score = theGame.calcScore()
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
    
    func addLeader(name: String, score: Int){
        //auto generate key
        let key = refLeaderboard.childByAutoId().key!
        let newScore = ["id":key,
                        "leaderName": name,
                        "leaderScore": score
            ] as [String : Any]
        refLeaderboard.child(key).setValue(newScore)
        print("score added \(name)")
    }
    
    @IBAction func newGame(_ sender: Any) {
        theGame = Set()
        numSets.text = "Number of Sets: \(theGame.numSets)"
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
