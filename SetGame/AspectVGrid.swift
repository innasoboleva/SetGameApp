//
//  AspectVGrid.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/23/22.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    var button1: () -> Void
    var button2: () -> Void
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView,
         button1: @escaping () -> Void, button2: @escaping () -> Void) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        self.button1 = button1
        self.button2 = button2
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
            HStack {
                Button(action: button1) {
                    Text("Add cards")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(20)
                }
                Spacer()
                Button(action: button2){
                    Text("New game")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(20)
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var colCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(colCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            colCount += 1
            rowCount = (itemCount + (colCount - 1)) / colCount
        } while colCount < itemCount
        if colCount > itemCount {
            colCount = itemCount
        }
        return floor(size.width / CGFloat(colCount))
    }
}
