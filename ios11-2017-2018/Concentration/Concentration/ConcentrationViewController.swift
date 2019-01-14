//
//  ViewController.swift
//  Concentration
//
//  Created by Abdoulaye Diallo on 6/6/18.
//  Copyright © 2018 Abdoulaye Diallo. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairedCards )
    
    public var numberOfPairedCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    
    fileprivate func updateFlipCountLabel() {
        
        let attributes:  [NSAttributedStringKey: Any ] = [ .strokeWidth: 5.0, .strokeColor: UIColor.black]
        let attributtedString = NSAttributedString(string: "Flips:\(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributtedString
        
    }
    
    var flipCount = 0 {
        didSet
        {
            updateFlipCountLabel()
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak  private var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBAction private func touchCard(_ sender:UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of:sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card is not in cardButtons.")
        }
    }
    
    func updateViewFromModel(){
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp  {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor =  card.isMatched ?  #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    var theme: String? {
        didSet{
            emojiChoices =  [theme ?? "" ]
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = [ "🎃", "👻", "🙀", "👻", "😈", "🐎", "👺" , "👹", "💀", "☠️", "⚰️" ]
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card)-> String {
        if emoji[card] == nil,  emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card]  ?? "?"
    }
}

extension Int {
    var  arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}
