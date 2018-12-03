//
//  InfiniteSet.swift
//  set_app
//
//  Created by Mia Bendy on 11/25/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import Foundation
import UIKit

//subclass of game for infinite/practice mode
class InfiniteSet : Game{
    var discardDeck:Deck //this game utilizes a discard deck
    
    //initializer to set discard deck to be empty at first
    override init(){
        let temp:[Card] = []
        discardDeck = Deck(cards: temp) //make an empty discard deck
        super.init()
    }
    
    
    //pass thru index of cards in displayedCards to determine if it is a set
    //if the cards are a set, then they're removed from the displayed cards and three new ones are added and increments number of sets
    //if there are no sets after adding three new cards, it adds more cards until there is a set
    override func removeSet(index1:Int, index2:Int, index3:Int){
        let card1:Card = displayedCards[index1]
        let card2:Card = displayedCards[index2]
        let card3:Card = displayedCards[index3]
        let isSet:Bool = self.isSet(card1: card1, card2: card2, card3: card3) //check if the cards form a set
        if isSet{ // if the cards a set
            numSets = numSets + 1 //increment number of sets
            if displayedCards.count <= 12 { //if there are 12 cards displayed
                discardDeck.addCard(card: displayedCards[index1]) //add old cards to discard deck
                discardDeck.addCard(card: displayedCards[index2])
                discardDeck.addCard(card: displayedCards[index3])
                if !deck.isEmpty(){ //if deck isn't empty use it to draw three new cards
                    displayedCards[index1] = deck.drawCard()
                    displayedCards[index2] = deck.drawCard()
                    displayedCards[index3] = deck.drawCard()
                }
                else{ //if deck is empty set the deck to the discard deck, shuffle it, empty the discard deck, and draw three new cards
                    deck = discardDeck
                    deck.shuffleDeck()
                    discardDeck = Deck(cards: [])
                    displayedCards[index1] = deck.drawCard()
                    displayedCards[index2] = deck.drawCard()
                    displayedCards[index3] = deck.drawCard()
                }
            }
            else{ //if there are more than 12 cards we don't need to add new ones
                discardDeck.addCard(card: displayedCards[index1]) //discard the cards that formed a set
                discardDeck.addCard(card: displayedCards[index2])
                discardDeck.addCard(card: displayedCards[index3])
                var indices = [index1, index2, index3] //sort indices because we must remove them from the array from largest index to smallest
                indices.sort()
                displayedCards.remove(at: indices[2])
                displayedCards.remove(at: indices[1])
                displayedCards.remove(at: indices[0])
            }
        }
        while noSets(){ //while there are no sets displayed add three cards 
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
