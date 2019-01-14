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
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardBehavior(in: animator)
    
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
            cardBehavior.addItem(cardView)
        }
    }
    
    private var faceCardViews: [PlayingCardView] {
        return cardViews.filter{ $0.isFaceUp && !$0.isHidden }
    }
    
    
    private var faceViewCards:[PlayingCardView] {
        return cardViews.filter{  $0.isFaceUp && !$0.isHidden }
    }
    
    private var faceUpCardViewsMatch: Bool {
        return  faceCardViews.count == 2  && faceCardViews[0].rank == faceCardViews[1].rank && faceCardViews[0].suit == faceCardViews[1].suit
    }
    
    
    var lastChosenCardView : PlayingCardView?
    
    @objc func flipCard( _ recognizer: UITapGestureRecognizer)
    {
        switch recognizer.state {
        case .ended:
            if let chosenCardView = recognizer.view as? PlayingCardView, faceCardViews.count < 2 {
                lastChosenCardView = chosenCardView
                cardBehavior.removeItem(chosenCardView)
                UIView.transition(
                    with: chosenCardView, duration: 3.0,
                    options: [.transitionFlipFromLeft],
                    animations: { chosenCardView.isFaceUp = !chosenCardView.isFaceUp },
                    completion: { finished in
                        let cardToAnimate = self.faceCardViews
                        if self.faceUpCardViewsMatch {
                            
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.6,
                                delay: 0,
                                options: [],
                                animations: {
                                    cardToAnimate.forEach{
                                        $0.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                                        $0.alpha = 0.0
                                    }
                            },
                                completion: { (position) in
                                    cardToAnimate.forEach{
                                        $0.transform = .identity
                                        $0.alpha = 1
                                        $0.isHidden = true
                                    }
                            }
                            )
                            
                        }
                        else if  cardToAnimate.count == 2 {
                            if chosenCardView == self.lastChosenCardView{
                                cardToAnimate.forEach{ cardView in
                                    UIView.transition(
                                        with:cardView, duration: 0.6,
                                        options: [.transitionFlipFromLeft],
                                        animations: { cardView.isFaceUp =  false },
                                        completion: { finished in
                                            self.cardBehavior.addItem(cardView)
                                    }
                                    )
                                }
                            } else {
                                if !chosenCardView.isFaceUp {
                                    self.cardBehavior.addItem(chosenCardView)
                                }
                            }
                        }
                }
                )
            }
        default: break
        }
    }
    
}

