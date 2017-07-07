//
//  CassiniViewController.swift
//  CassiniDemo
//
//  Created by Abdoulaye Diallo on 6/23/17.
//  Copyright © 2017 Diaryconnect. All rights reserved.
//
import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate
{
    // this is just our normal "put constants in a struct" thing
    // but we call it Storyboard, because all the constants in it
    // are strings in our Storyboard.
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = segue.destination.contents as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName) as! URL
                ivc.title = imageName
            }
        }
    }
    
}

extension UIViewController {
    var contents : UIViewController {
        if let  navcon = self as? UINavigationController {
             return navcon.visibleViewController ?? self
        } else {
             return self
        }
        
        
    }
    
}




