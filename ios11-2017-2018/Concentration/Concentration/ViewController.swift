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
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips:\(flipCount)"
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    var emojiChoices: [String] = ["🎃 ","👻","🎃 ","👻"]
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBAction func touchCard(_ sender:UIButton) {
        flipCount += 1
        if let  cardNumber = cardButtons.lastIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("Card is not in the array")
        }
    }
    
    func flipCard(withEmoji  emoji:String, on button: UIButton) {
        
        if  button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

