//
//  SetGame.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/23/22.
//

import SwiftUI

class SetGame: ObservableObject {
    
    typealias Card = Game<String>.Card
    
    static func createGame() -> Game<String> {
        Game(numberOfCards: 16)
    }
    
    @Published private var model = SetGame.createGame()
    
    var cards: Array<Card> {
        return model.cards
    }
}
