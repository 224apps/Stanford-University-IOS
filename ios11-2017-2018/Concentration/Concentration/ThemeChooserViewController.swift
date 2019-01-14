//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Abdoulaye Diallo on 8/14/18.
//  Copyright © 2018 Abdoulaye Diallo. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {
    
    // MARK: - Navigation
    let themes = [
        "Sports":"🏁⚾️🏓⛹🏽‍♂️🚴🏻‍♀️🤽‍♀️🎽🏉🎾🎱⚽️🎿🏀🥋",
        "Animals": "🐻🐀😺🐊🐏🐐🐫🐪🐩🐨🐧🐦🐥🐒",
        "Faces": "🙎‍♀️🙍🏻‍♂️💑💂🏻‍♀️🤦🏻‍♀️💑👱‍♀️💇🏽‍♂️👿🚶‍♂️🕵️‍♂️💀👻😈"
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseTheme"{
            if let themeName = ( sender as? UIButton)?.currentTitle , let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController{
                    cvc.theme  = theme
                }
            }
        }
    }
    
}
