//
//  ViewController.swift
//  PlayingCardView
//
//  Created by Abdoulaye Diallo on 8/12/18.
//  Copyright © 2018 Abdoulaye Diallo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended: playingCardView.isFaceUp = !playingCardView.isFaceUp
        default: break
        }
    }
    var deck = PlayingCardDeck()

    @IBOutlet weak var playingCardView: PlayingCardView!{
        didSet{
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
             swipe.direction = [.left, .right]
             playingCardView.addGestureRecognizer(swipe)

            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizerBy:)))
            playingCardView.addGestureRecognizer(pinch)
            
            let screenEdgeSwipe = UIScreenEdgePanGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.screenpan(recognizer:)))
             playingCardView.addGestureRecognizer(screenEdgeSwipe)
        }
    }
    @objc func nextCard(){
        if let card = deck.draw(){
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        for _ in 1...10 {
            if let card = deck.draw(){
                print("\(card)")
            }
        }
    }
}


