//
//  Game.swift
//  set_app
//
//  Created by Mia Bendy on 11/28/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import Foundation
import UIKit

//Base class for a game
class Game{
    var deck:Deck = Deck() //a deck of cards
    var numSets:Int = 0 //number of sets
    var displayedCards:[Card] //array of cards being displayed
    var selectedCards:[Int] = [] //array of cards selected by player
    
    //initializes the game by adding cards to be displayed
    init(){
        deck.shuffleDeck()
        var temp:[Card] = []
        for _ in 0...11{
            temp.append(deck.drawCard())
        }
        displayedCards = temp
    }
    
    //checks if three cards are a set
    //returns true if they are a set, and false if they are not a set
    func isSet(card1:Card, card2:Card, card3:Card)->Bool{
        let color:Bool = ((card1.color == card2.color) && (card2.color == card3.color)) || ((card1.color != card2.color) && (card1.color != card3.color) && (card2.color != card3.color))
        
        let shading:Bool = ((card1.shading == card2.shading) && (card2.shading == card3.shading)) || ((card1.shading != card2.shading) && (card1.shading != card3.shading) && (card2.shading != card3.shading))
        
        let shape:Bool = ((card1.shape == card2.shape) && (card2.shape == card3.shape)) || ((card1.shape != card2.shape) && (card1.shape != card3.shape) && (card2.shape != card3.shape))
        
        let number:Bool = ((card1.number == card2.number) && (card2.number == card3.number)) || ((card1.number != card2.number) && (card1.number != card3.number) && (card2.number != card3.number))
        
        let isSet:Bool = (color && shading) && (shading && shape) && (shape && number)
        
        if isSet{
            return true
        }
        else{
            return false
        }
    }
    
    //to select a card for a set adds it to the array of selected indices
    //returns true if the list of selected cards has reached three
    //returns false if the list of selected cards is not at three
    func selectCard(index: Int)->Bool{
        if !selectedCards.contains(index){ //if the card isn't selected, add it to the list of selected cards
            selectedCards.append(index)
        }
        if selectedCards.count == 3 { //if it reaches three then call remove set
            removeSet(index1: selectedCards[0], index2: selectedCards[1], index3: selectedCards[2])
            selectedCards = [] //empty selected cards
            return true //return that there were three cards selected
        }
        else{
            return false //return that there were not three cards selected
        }
    }
    
    /*
    func deselectCard(index: Int){
        for num in 0..<selectedCards.count{
            if selectedCards[num] == index{
                selectedCards.remove(at: num)
            }
        }
    }*/
    
    //this function must be overriden in subclasses
    func removeSet(index1: Int, index2: Int, index3: Int){
        fatalError("Must Override")
    }
    
    //checks if there are no sets in the cards displayed
    func noSets()->Bool{
        for index1 in 0..<(displayedCards.count - 2){
            for index2 in (index1+1)..<(displayedCards.count - 1){
                for index3 in (index2+1)..<(displayedCards.count){ //iterate through all combinations of 3 cards
                    let card1 = displayedCards[index1]
                    let card2 = displayedCards[index2]
                    let card3 = displayedCards[index3]
                    
                    let isSet:Bool = self.isSet(card1: card1, card2: card2, card3: card3) //check if it is a set
                    
                    if isSet{
                        return false //if there is a set return false
                    }
                }
            }
        }
        
        return true //if there are no sets return true
    }
    
}
