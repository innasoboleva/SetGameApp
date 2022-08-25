//
//  SetGameApp.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/19/22.
//

import SwiftUI

@main
struct SetGameApp: App {
    let game = SetGame()
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: game)
        }
    }
}
