//
//  SetGameView.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/19/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGame
    
    var body: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: (2/3), content: { card in
            cardView(for: card)
                .padding(1)
        })
        .padding()
    }
    
    @ViewBuilder
    private func cardView(for card: SetGame.Card) -> some View {
        CardView(card)
            .padding(4)
    }
}

struct CardView: View {
    private let card: SetGame.Card
    
    init(_ card: SetGame.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                VStack {
                    ForEach(1...3, id: \.self) {_ in
                        ZStack {
                            RoundedRectangle(cornerRadius: 25).stroke(.red, lineWidth: 4)
                            RoundedRectangle(cornerRadius: 25).stripes()
                        }
                        
//                        ZStack {
//                            SquiggleShape().stroke(.red, lineWidth: 4)
//                            SquiggleShape().stripes()
//                        }
                            .padding(4)
                    }
                }
                .padding(6)
            }
            .cardify()
        })
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
//        static let piePadding: CGFloat = 5
//        static let pieOpacity: CGFloat = 0.5
        static let fontSize: CGFloat = 10
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        SetGameView(viewModel: game)
    }
}
