//
//  Game.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/23/22.
//
import SwiftUI
import Foundation

struct Game /*where CardContent: Equatable*/ {
    var cards: Array<Card>
    var extraCards: Array<Card> = []
    
    init() {
        cards = []
        
//        for index in 0..<numberOfCards {
//            cards.append(Card(id: index))
//        }
        let shapes = [ShapeCard.diamond, ShapeCard.rectangle, ShapeCard.squiggle]
        let fillingShape = [ShapeFill.striped, ShapeFill.cleared, ShapeFill.filled]
        let colorShape = [Color.red, Color.blue, Color.purple]
        var count = 1
        for number in 1...3 {
            for someShape in shapes {
                for filling in fillingShape {
                    for col in colorShape {
                        cards.append(Card(id: count, stripes: filling, color: col, count: number, shaped: someShape))
                        count += 1
                    }
                }
            }
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
        let stripes: ShapeFill
        let color: Color
        let count: Int
        let shaped: ShapeCard
    }
}
enum ShapeCard {
    case diamond, rectangle, squiggle
}

enum ShapeFill {
    case striped, cleared, filled
}


// Iterating over enum sequence
public protocol EnumSequence {
    init?(rawValue: Int)
}

public extension EnumSequence {

    static var items: [Self] {
        var caseIndex: Int = 0
        let interator: AnyIterator<Self> = AnyIterator {
            let result = Self(rawValue: caseIndex)
            caseIndex += 1
            return result
        }
        return Array(interator)
    }
}
