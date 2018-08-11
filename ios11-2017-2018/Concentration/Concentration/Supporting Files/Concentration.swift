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
    
    //MARk - Game Functions
    func chooseCard(at index: Int) {
    
    }
    
}
