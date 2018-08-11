//
//  Concentration.swift
//  Concentration
//
//  Created by Abdoulaye Diallo on 6/10/18.
//  Copyright © 2018 Abdoulaye Diallo. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    init(numberOfPairsOfCards: Int ) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [ card, card]
        }
    }
    var indexOfOneAndOnlyFaceUpCard: Int?
    //MARk - Game Functions
    func chooseCard(at index: Int) {
        if  !cards[index].isMatched {
            if let matchedIndex =  indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                // check if the card matched
                if cards[matchedIndex].identifier == cards[index].identifier {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in  cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
}
