//
//  Set.swift
//  set_app
//
//  Created by Mia Bendy on 11/25/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import Foundation
import UIKit

class Set : Game{
    
    var seconds = 0
    
    //pass thru index of cards in displayedCards to determine if it is a set
    //if the cards are a set, then they're removed from the displayed cards and three new ones are added, and increments number of sets
    //after adding the new cards, it checks if there are no sets displayed and if there are no sets it adds more cards
    override func removeSet(index1:Int, index2:Int, index3:Int){
        let card1:Card = displayedCards[index1]
        let card2:Card = displayedCards[index2]
        let card3:Card = displayedCards[index3]
        let isSet:Bool = self.isSet(card1: card1, card2: card2, card3: card3) //check if cards form a set
        if isSet{ //if the cards are a set
            numSets = numSets + 1 //increment number of sets
            if displayedCards.count <= 12{ //if displayed cards are 12
                if deck.isEmpty(){ //if the deck is empty then just remove the sets
                    var indices = [index1, index2, index3]
                    indices.sort()
                    displayedCards.remove(at: indices[2])
                    displayedCards.remove(at: indices[1])
                    displayedCards.remove(at: indices[0])
                }
                if !deck.isEmpty(){ //if deck isn't empty draw three new cards
                    displayedCards[index1] = deck.drawCard()
                    displayedCards[index2] = deck.drawCard()
                    displayedCards[index3] = deck.drawCard()
                }
            }
            else{ //if there are more than 12 cards displayed simply remove the three that make the set
                var indices = [index1, index2, index3]
                indices.sort()
                displayedCards.remove(at: indices[2])
                displayedCards.remove(at: indices[1])
                displayedCards.remove(at: indices[0])
            }
        }
        while self.noSets(){ //while there are no sets in the displayed cards, keep adding three cards at a time
            for _ in 0...2{
                if !deck.isEmpty(){
                    displayedCards.append(deck.drawCard())
                }
                else{ // if the deck is empty, then return because no more cards can be added (game should be over)
                    return
                }
            }
        }
    }
    
    //function to keep track of time
    func tick() {
        seconds = seconds + 1
    }
    
    //function to put the seconds into minute format
    func getTimeString()->String {
        var secs: String = ""
        if seconds%60 < 10 {
            secs += "0"
        }
        secs += "\(seconds%60)"
        return "\(seconds/60):\(secs)"
    }
    
    //checks if the game is over, returns true if game is over, false if game is not over 
    func gameOver()->Bool{
        if deck.count() == 0{ //if deck is empty
            if self.noSets(){ //if there are no sets
                //elapsedTime = Date().timeIntervalSince(started)
                return true //return true because game is over
            }
            else{
                return false //return false because game is not over
            }
        }
        else{
            return false //return false because game is not over
        }
    }
    
    //function to calculate the score
    func calcScore()->Int{
        let score:Double = (3600 - Double(self.seconds))*(Double(self.numSets)/27)
        var intScore:Int = Int(score)
        if intScore < 0 {
            intScore = 0
        }
        return intScore
    }
    
}
