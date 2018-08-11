//
//  ViewController.swift
//  Concentration
//
//  Created by Abdoulaye Diallo on 6/6/18.
//  Copyright © 2018 Abdoulaye Diallo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
    
    var flipCount = 0 { didSet{ flipCountLabel.text = "Flips:\(flipCount)" } }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBAction func touchCard(_ sender:UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of:sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card is not in cardButtons.")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp  {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor =  card.isMatched ?  #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = [ "🎃", "👻", "🎃", "👻" , "😈", "🐎", "👺" , "👹", "💀", "☠️", "⚰️" ]
    var emoji = [Int: String]()
    func emoji(for card: Card)-> String {
        if emoji[card.identifier] == nil,  emojiChoices.count > 0 {
            let randomIndex =  Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emojiChoices[card.identifier]  ?? "?"
    }
    
    
    
    
    
}
