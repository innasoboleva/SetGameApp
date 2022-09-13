//
//  SetGame.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/23/22.
//

import SwiftUI

class SetGame: ObservableObject {
    
    typealias Card = Game.Card
    
    static func createGame() -> Game {
        Game()
    }
    
    @Published private var model = SetGame.createGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    func threeMore() {
        model.threeMore()
    }
    
    func newGame() {
        model = SetGame.createGame()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
