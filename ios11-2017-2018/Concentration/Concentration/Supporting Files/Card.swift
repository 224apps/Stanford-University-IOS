//
//  Card.swift
//  Concentration
//
//  Created by Abdoulaye Diallo on 6/10/18.
//  Copyright © 2018 Abdoulaye Diallo. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier : Int

    static var identifierFactory = 0

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return  identifierFactory
    }
}


