//
//  Deck.swift
//  set_app
//
//  Created by Mia Bendy on 11/25/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import Foundation
import UIKit

//Code from: https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
// end of copied code

class Deck{
    var cards:[Card]
    
    //"default" constructor of the 81 card deck
    init(){
        var tempCards:[Card] = []
        let shapes:[Card.Shape] = [Card.Shape.circle, Card.Shape.square, Card.Shape.triangle]
        let shadings:[Card.Shading] = [Card.Shading.outlined, Card.Shading.solid, Card.Shading.striped]
        
        for shape in shapes{
            for shading in shadings{
                for num in 1...3{
                    for color in 0...2{
                        let card:Card = Card(s: shape, c: color, n: num, sh: shading)
                        tempCards.append(card)
                    }
                }
            }
        }

        cards = tempCards.shuffled()
    }
    
    //constructor for a deck with a specified array of cards
    init(cards: [Card]){
        self.cards = cards
    }
    
    //shuffles the deck
    func shuffleDeck(){
        cards = cards.shuffled()
    }
    
    //make sure only to call this after checking that the deck is not empty (otherwise will cause problems)
    func drawCard()->Card{
        return cards.removeFirst()
    }
    
    //adds a card to the deck
    func addCard(card: Card){
        cards.append(card)
    }
    
    //returns number of cards left in the deck
    func count()->Int{
        return cards.count
    }
    
    //returns true if deck is empty
    func isEmpty()->Bool{
        return (cards.count == 0)
    }
}
