//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Станислав Белоусов on 29/05/2019.
//  Copyright © 2019 Станислав Белоусов. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let themes = [
        "Sports":"⚽️🏀🎾🎱🏂🚴‍♂️🎿🏉🏒🛹",
        "Animals":"🐅🐖🐓🐇🐿🐩🦊🦁🐨🐳",
        "Faces":"👩‍🦳👱‍♂️😎🧐😛🤩🤪🤬🥶👹"
    ]
    

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.theme = theme
                    }
                }
            }
        }
}

