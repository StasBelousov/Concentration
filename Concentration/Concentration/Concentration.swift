//
//  Concentration.swift
//  Concentration
//
//  Created by Станислав Белоусов on 20/01/2019.
//  Copyright © 2019 Станислав Белоусов. All rights reserved.
//

import Foundation

class Concentration {
    
   private(set) var cards = [Card]()
    
   private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index:Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
        } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsCards: Int) {
            assert(numberOfPairsCards > 0, "numberOfPairsCards.init (at: \(index)): must have at least one pair of cards")
        for _ in 1...numberOfPairsCards {
            let card = Card()
            cards += [card, card]
        }
    }
//TODO shaflle cards

}
