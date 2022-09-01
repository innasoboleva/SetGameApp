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
            if card.count == 2 {
                ZStack {
                    VStack {
                        ForEach(1...card.count, id: \.self) {_ in
                            createCardView(card).padding(4)
                        }
                    }
                    .padding(6)
                }
                .padding(.vertical)
                .cardify()
            } else {
                ZStack {
                    VStack {
                        ForEach(1...3, id: \.self) {num in
                            if card.count == 1 && (num == 1 || num == 3) {
                                createCardView(card).padding(4).opacity(0)
                            } else {
                                createCardView(card).padding(4)
                            }
                        }
                    }
                    .padding(6)
                }
                .cardify()
            }
        })
    }
    
    private func createCardView(_ card: SetGame.Card) -> some View {
        ZStack {
            switch card.stripes {
            case ShapeFill.striped:
                chooseShape().stroke(card.color, lineWidth: 2)
                chooseShape().stripes(color: UIColor(card.color))
            case ShapeFill.cleared:
                    chooseShape().stroke(card.color, lineWidth: 2)
            case ShapeFill.filled:
                    chooseShape().fill(card.color)
            }
        }
    }
    
    private func chooseShape() -> some Shape {
        switch card.shaped {
        case ShapeCard.diamond:
            return AnyShape(DiamondShape())
        case ShapeCard.rectangle:
            return AnyShape(RoundedRectangle(cornerRadius: 25))
        case ShapeCard.squiggle:
            return AnyShape(SquiggleShape())
        }
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
