//
//  Game.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/23/22.
//

import Foundation

struct Game<CardContent> /*where CardContent: Equatable*/ {
    private(set) var cards: Array<Card>
    
    init(numberOfCards: Int) {
        cards = []
        
        for index in 0..<numberOfCards {
            cards.append(Card(id: index))
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    struct Card: Identifiable {
        let id: Int
    }
}
