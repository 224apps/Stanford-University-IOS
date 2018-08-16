//
//  ViewController.swift
//  PlayingCardView
//
//  Created by Abdoulaye Diallo on 8/12/18.
//  Copyright © 2018 Abdoulaye Diallo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardViews: [PlayingCardView]!
    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var  cards  = [ PlayingCard]()
        for _ in 1...((cardViews.count + 1) / 2) {
            let card = deck.draw()!
            cards += [ card, card]
        }
        for cardView in  cardViews {
            cardView.isFaceUp =  false
            let  card = cards.remove(at:cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
        }
    }
    

    
    @objc func flipCard( _ recognizer: UITapGestureRecognizer)
    {
        switch recognizer.state {
        case .ended:
            if let chosenCardView = recognizer.view as? PlayingCardView {
                UIView.transition(with: chosenCardView,
                                  duration: 0.5,
                                  options: [.transitionFlipFromLeft],
                                  animations: { chosenCardView.isFaceUp = !chosenCardView.isFaceUp })
            }
        default: break
        }
    }
    
}

