//
//  Cardify.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/25/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    
//    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
           // if isFaceUp {
             //   shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
//            } else {
//                shape.fill()
//            }
            content.opacity(1)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify() -> some View {
        self.modifier(Cardify())
    }
}
