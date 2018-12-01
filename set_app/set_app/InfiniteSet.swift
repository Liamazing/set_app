//
//  InfiniteSet.swift
//  set_app
//
//  Created by Mia Bendy on 11/25/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import Foundation
import UIKit

class InfiniteSet : Game{
    var discardDeck:Deck
    
    
    override init(){
        let temp:[Card] = []
        discardDeck = Deck(cards: temp) //make an empty discard deck
        super.init()
    }
    
    
    //pass thru index of cards in displayedCards to determine if it is a set
    //if the cards are a set, then they're removed from the displayed cards and three new ones are added
    //if the cards are a set, also increments number of sets
    //if there are no sets after adding three new cards, it adds more cards until there is a set
    override func removeSet(index1:Int, index2:Int, index3:Int){
        let card1:Card = displayedCards[index1]
        let card2:Card = displayedCards[index2]
        let card3:Card = displayedCards[index3]
        let isSet:Bool = self.isSet(card1: card1, card2: card2, card3: card3)
        if isSet{
            numSets = numSets + 1
            if displayedCards.count <= 12 {
                discardDeck.addCard(card: displayedCards[index1])
                discardDeck.addCard(card: displayedCards[index2])
                discardDeck.addCard(card: displayedCards[index3])
                if !deck.isEmpty(){
                    displayedCards[index1] = deck.drawCard()
                    displayedCards[index2] = deck.drawCard()
                    displayedCards[index3] = deck.drawCard()
                }
                else{
                    deck = discardDeck
                    deck.shuffleDeck()
                    discardDeck = Deck(cards: [])
                    displayedCards[index1] = deck.drawCard()
                    displayedCards[index2] = deck.drawCard()
                    displayedCards[index3] = deck.drawCard()
                }
            }
            else{
                discardDeck.addCard(card: displayedCards[index1])
                discardDeck.addCard(card: displayedCards[index2])
                discardDeck.addCard(card: displayedCards[index3])
                var indices = [index1, index2, index3]
                indices.sort()
                displayedCards.remove(at: indices[2])
                displayedCards.remove(at: indices[1])
                displayedCards.remove(at: indices[0])
            }
        }
        while noSets(){
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
