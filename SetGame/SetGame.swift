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
        // Game(numberOfCards: 16)
        var game = Game()
        game.cards.shuffle()
        for i in 0...15 {
            game.extraCards.append(game.cards[i])
            game.cards.remove(at: i)
        }
        return game
    }
    
    @Published private var model = SetGame.createGame()
    
    var cards: Array<Card> {
        return model.extraCards
    }
}
