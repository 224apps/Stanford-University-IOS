//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abdoulaye Diallo on 5/28/20.
//  Copyright © 2020 Abdoulaye Diallo. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    //MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: -  Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: [String]  = ["👻", "🎃"]
        return MemoryGame<String>(numberOfPairOfCards: 2){ pairIndex in  emojis[pairIndex] }
    }
}


