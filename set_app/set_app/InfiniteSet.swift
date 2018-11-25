//
//  InfiniteSet.swift
//  set_app
//
//  Created by Mia Bendy on 11/25/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import Foundation
import UIKit

class InfiniteSet{
    var deck:Deck = Deck()
    var discardDeck:Deck
    var numSets:Int = 0
    var displayedCards:[Card]
    
    init(){
        var temp:[Card] = []
        discardDeck = Deck(cards: temp) //make an empty discard deck
        for _ in 0...11{
            temp.append(deck.drawCard()) //add 12 cards to displayed cards
        }
        displayedCards = temp
        deck.shuffleDeck()
    }
    
    //checks if three cards are a set 
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
    
    //checks if there are no sets in the cards displayed
    func noSets()->Bool{
        for index1 in 0..<(displayedCards.count - 2){
            for index2 in (index1+1)..<(displayedCards.count - 1){
                for index3 in (index2+1)..<(displayedCards.count){
                    let card1 = displayedCards[index1]
                    let card2 = displayedCards[index2]
                    let card3 = displayedCards[index3]
                    
                    let isSet:Bool = self.isSet(card1: card1, card2: card2, card3: card3)
                    
                    if isSet{
                        return false
                    }
                }
            }
        }
        
        return true
    }
    
    //pass thru index of cards in displayedCards to determine if it is a set
    //if the cards are a set, then they're removed from the displayed cards and three new ones are added
    //if the cards are a set, also increments number of sets
    //if there are no sets after adding three new cards, it adds more cards until there is a set
    func removeSet(index1:Int, index2:Int, index3:Int){
        let card1:Card = displayedCards[index1]
        let card2:Card = displayedCards[index2]
        let card3:Card = displayedCards[index3]
        let isSet:Bool = self.isSet(card1: card1, card2: card2, card3: card3)
        if isSet{
            discardDeck.addCard(card: displayedCards.remove(at: index1))
            discardDeck.addCard(card: displayedCards.remove(at: index2))
            discardDeck.addCard(card: displayedCards.remove(at: index3))
            numSets = numSets + 1
            for _ in 0...2{
                if deck.isEmpty(){
                    deck = discardDeck
                    deck.shuffleDeck()
                    discardDeck = Deck(cards: [])
                }
                displayedCards.append(deck.drawCard())
            }
        }
        while self.noSets(){
            for _ in 0...2{
                if deck.isEmpty(){ //if the deck ever empties just refill it
                    deck = discardDeck
                    deck.shuffleDeck()
                    discardDeck = Deck(cards: [])
                }
                displayedCards.append(deck.drawCard())
            }
        }
    }
    
}
