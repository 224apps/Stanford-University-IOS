//
//  EmotionsViewController.swift
//  FaceDemo
//
//  Created by Abdoulaye Diallo on 5/30/17.
//  Copyright © 2017 Abdoulaye Diallo. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    
    
    private let emotionalFacesDict: Dictionary<String, FacialExpression> = [
        "sad":FacialExpression(eyes: .Closed, mouth: .Frown),
        "happy": FacialExpression(eyes: .Open, mouth: .Smile),
        "worried": FacialExpression( eyes: .Open, mouth: .Smirk)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
         print("Memory did receive memory warning")
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController{
             destinationViewController = navigationController.visibleViewController ??  destinationViewController
            
        }
        
        if let faceViewController = destinationViewController as? FaceViewController,
            let identifier = segue.identifier,
            let expression = emotionalFacesDict[identifier] {
            faceViewController.expression =  expression
    
        }
        
    }
    
    
    
    
    
    
}
