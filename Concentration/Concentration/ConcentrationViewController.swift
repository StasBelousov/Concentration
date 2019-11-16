//
//  ViewController.swift
//  Concentration
//
//  Created by Станислав Белоусов on 19/01/2019.
//  Copyright © 2019 Станислав Белоусов. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
   private lazy var game = Concentration(numberOfPairsCards: numberOfPairsCards)
    
    var numberOfPairsCards: Int {
        return (visibleCardButton.count + 1) / 2
    }
    
    private func updateFlipCountLabel() {
        let attibutes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(
            string:  traitCollection.verticalSizeClass == .compact ? "Flips:\n\(flipCount)" : "Flips: \(flipCount)",
        attributes: attibutes
        )
        flipCountLabel.attributedText = attributedString
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }
    
    private (set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }

    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButton: [UIButton]!
    
    private var visibleCardButton: [UIButton]! {
        return cardButton?.filter { !$0.superview!.isHidden}
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    @IBAction private func TouchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = visibleCardButton.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        
        }
        }
    func updateViewFromModel () {
        if visibleCardButton != nil {
        for index in visibleCardButton.indices {
            let button = visibleCardButton[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    }

    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "😻👻🍏😈👽🚗👠🐠❄️👹"
    private var emoji = [Card:String]()
    
    private func emoji (for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }else {
            return 0
        }
    }
}



