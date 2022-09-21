//
//  Game.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/23/22.
//
import SwiftUI
import Foundation

struct Game {
    private(set) var cards: Array<Card> = []
    private(set) var extraCards: Array<Card>
    
    init() {
        extraCards = []
        
        let shapes = [ShapeCard.diamond, ShapeCard.rectangle, ShapeCard.squiggle]
        let fillingShape = [ShapeFill.striped, ShapeFill.cleared, ShapeFill.filled]
        let colorShape = [Color.red, Color.blue, Color.purple]
        var count = 1
        for number in 1...3 {
            for someShape in shapes {
                for filling in fillingShape {
                    for col in colorShape {
                        extraCards.append(Card(id: count, stripes: filling, color: col, count: number, shaped: someShape))
                        count += 1
                    }
                }
            }
        }
        extraCards.shuffle()
        for i in 0...15 {
            cards.append(extraCards[i])
        }
        for _ in 0...15 {
            extraCards.remove(at: 0)
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            cards[chosenIndex].isPicked.toggle()
        }
        
        let pickedCards = cards.indices.filter({ cards[$0].isPicked })
        if pickedCards.count == 3 {
            let frt = pickedCards[0]
            let scd = pickedCards[1]
            let thr = pickedCards[2]
            if ((cards[frt].shaped == cards[scd].shaped && cards[frt].shaped == cards[thr].shaped) || (cards[frt].shaped != cards[scd].shaped && cards[frt].shaped != cards[thr].shaped && cards[scd].shaped != cards[thr].shaped))
                &&
                ((cards[frt].stripes == cards[scd].stripes && cards[frt].stripes == cards[thr].stripes) || (cards[frt].stripes != cards[scd].stripes && cards[frt].stripes != cards[thr].stripes && cards[scd].stripes != cards[thr].stripes))
                &&
                ((cards[frt].color == cards[scd].color && cards[frt].color == cards[thr].color) || (cards[frt].color != cards[scd].color && cards[frt].color != cards[thr].color && cards[scd].color != cards[thr].color))
                &&
                ((cards[frt].count == cards[scd].count && cards[frt].count == cards[thr].count) || (cards[frt].count != cards[scd].count && cards[frt].count != cards[thr].count && cards[scd].count != cards[thr].count))
            {
                for i in pickedCards {
                    cards[i].isMatched = true
                }
                if cards.count <= Const.cardsVisible {
                    addCard(at: pickedCards)
                } else {
                    for _ in 0...2 {
                        removeCards()
                    }
                }
            } else {
                for i in pickedCards {
                    cards[i].isPicked = false
                }
            }
        }
    }
    
    mutating func addCard(at arr: [Int]) {
        let count = extraCards.count
        if count > 0 && count >= 3 {
            for i in 0...2 {
                cards.remove(at: arr[i])
                cards.insert(extraCards[i], at: arr[i])
            }
            for _ in 0...2 {
                extraCards.remove(at: 0)
            }
        } else {
            for i in 0..<count {
                cards.remove(at: arr[i])
                cards.insert(extraCards[i], at: arr[i])
            }
            for _ in 0..<count {
                extraCards.remove(at: 0)
            }
            for _ in 0..<2 {
                removeCards()
            }
        }
    }
    
    mutating func removeCards() {
        if let toRemove = cards.indices.first(where: {cards[$0].isMatched}) {
            cards.remove(at: toRemove)
        }
    }
    
    mutating func addCards() {
        let count = extraCards.count
        if count > 0 && count >= 3 {
            for i in 0...2 {
                cards.append(extraCards[i])
            }
            for _ in 0...2 {
                extraCards.remove(at: 0)
            }
        } else {
            for i in 0..<count {
                cards.append(extraCards[i])
            }
            for _ in 0..<count {
                extraCards.remove(at: 0)
            }
        }
    }
    
    mutating func threeMore() {
        if cards.count <= Const.cardsVisible {
            addCards()
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
        var isPicked: Bool = false
        var isMatched: Bool = false
    }
    
     struct Const {
        static let cardsVisible = 16
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
