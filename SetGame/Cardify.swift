//
//  Cardify.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/25/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isPicked: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            
            content.opacity(isPicked ? 0.5 : 1)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isPicked: Bool) -> some View {
        self.modifier(Cardify(isPicked: isPicked))
    }
}
