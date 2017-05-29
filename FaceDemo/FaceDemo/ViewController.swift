//
//  ViewController.swift
//  FaceDemo
//
//  Created by Abdoulaye Diallo on 6/16/16.
//  Copyright © 2016 Abdoulaye Diallo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var faceView: FaceView! {
        
        didSet{
            let handler = #selector(FaceView.changeScale(byReacting:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.increaseHappiness))
            swipeUpRecognizer.direction = .up
            
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.decreaseHappiness))
            swipeDownRecognizer.direction = .down
            
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            
            
            
            
            UpdateUI()
        }
    }
    
    func increaseHappiness(){
        
        expression =  expression.happier
    }
    func decreaseHappiness(){
        
        expression = expression.sadder
    }
    
    func toggleEyes(byReactingTo  tapGestureRecognizer: UITapGestureRecognizer) {
        if tapGestureRecognizer.state == .ended{
            let eyes: FacialExpression.Eyes  = (expression.eyes == .Closed ) ? .Open : .Closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
        
        
    }
    
    var expression = FacialExpression(eyes: .Closed, mouth: .Frown){
        didSet{
            UpdateUI()
        }
        
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.Grin : 0.5, .Frown: -1.0, .Smile: 1.0, .Neutral:0.0, .Smirk: -0.5 ]
    
    private func UpdateUI(){
        
        switch expression.eyes {
        case .Open:
            faceView?.eyeOpen = true
        case .Closed:
            faceView?.eyeOpen = false
        case .Squinting:
            faceView?.eyeOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

