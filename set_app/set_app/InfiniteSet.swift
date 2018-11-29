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
        //= Deck(cards: [])
    
    override init(){
        let temp:[Card] = []
        discardDeck = Deck(cards: temp) //make an empty discard deck
        super.init()
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
