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
    var started:Date
    var elapsedTime:TimeInterval?
    var seconds = 0
    
    //constructs a classic set game
    override init(){
        started = Date()
        super.init()
    }
    
    //pass thru index of cards in displayedCards to determine if it is a set
    //if the cards are a set, then they're removed from the displayed cards and three new ones are added
    //if the cards are a set, also increments number of sets
    //after adding the new cards, it checks if there are no sets displayed and if there are no sets it adds more cards
    override func removeSet(index1:Int, index2:Int, index3:Int){
        let card1:Card = displayedCards[index1]
        let card2:Card = displayedCards[index2]
        let card3:Card = displayedCards[index3]
        let isSet:Bool = self.isSet(card1: card1, card2: card2, card3: card3)
        if isSet{
            numSets = numSets + 1
            if displayedCards.count <= 12{
                if deck.isEmpty(){
                    var indices = [index1, index2, index3]
                    indices.sort()
                    displayedCards.remove(at: indices[2])
                    displayedCards.remove(at: indices[1])
                    displayedCards.remove(at: indices[0])
                }
                if !deck.isEmpty(){
                    displayedCards[index1] = deck.drawCard()
                }
                if !deck.isEmpty(){
                    displayedCards[index2] = deck.drawCard()
                }
                if !deck.isEmpty(){
                    displayedCards[index3] = deck.drawCard()
                }
            }
            else{
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
    
    func tick() {
        seconds = seconds + 1
    }
    
    func getTimeString()->String {
        var secs: String = ""
        if seconds%60 < 10 {
            secs += "0"
        }
        secs += "\(seconds%60)"
        return "\(seconds/60):\(secs)"
    }
    
    //checks if the game is over (if deck is empty and if there are no sets)
    //if game is over then it calculates time elapsed (we will have to figure out a running timer later)
    func gameOver()->Bool{
        if deck.count() == 0{
            if self.noSets(){
                elapsedTime = Date().timeIntervalSince(started)
                return true
            }
            else{
                return false
            }
        }
        else{
            return false
        }
    }
    
    
}
