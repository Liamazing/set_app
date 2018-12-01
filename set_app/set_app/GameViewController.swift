//
//  GameViewController.swift
//  set_app
//
//  Created by Mia Bendy on 12/1/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var theGame:Game = Set()
    var selectedCards:[Int] = []
    
    @IBOutlet weak var theDisplayedCards: UICollectionView!
    @IBOutlet weak var theNewGameButton: UIButton!
    @IBOutlet weak var numSets: UILabel!
    @IBOutlet weak var switchMode: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
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
        print("collectionView")
        let theCard:Card = theGame.displayedCards[indexPath.item]
        if theCard.number == 1{
            print("oneCard")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCard", for: indexPath) as! SingleCard
            cell.selectedBackgroundView?.backgroundColor = UIColor.gray
            cell.setCard(card: theCard)
            return cell
            
        }
        else if theCard.number == 2{
            print("twoCard")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doubleCard", for: indexPath) as! DoubleCard
            cell.selectedBackgroundView?.backgroundColor = UIColor.gray
            cell.setCard(card: theCard)
            return cell
        }
        else {
            print("threeCard")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tripleCard", for: indexPath) as! TripleCard
            cell.selectedBackgroundView?.backgroundColor = UIColor.gray
            cell.setCard(card: theCard)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if theGame.selectCard(index: indexPath.item){
            theDisplayedCards.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        theGame.deselectCard(index: indexPath.item)
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
