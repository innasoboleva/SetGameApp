//
//  Shapes.swift
//  SetGame
//
//  Created by Inna Soboleva on 8/19/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct DiamondShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let startingPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let secondPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let thirdPoint = CGPoint(x: rect.minX, y: rect.midY)
        let lastPoint = CGPoint(x: rect.midX, y: rect.minY)
        
        var p = Path()
        p.move(to: startingPoint)
        p.addLine(to: secondPoint)
        p.addLine(to: thirdPoint)
        p.addLine(to: lastPoint)
        
        return p
    }
}

struct SquiggleShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
                
        path.move(to: CGPoint(x: 104.0, y: 15.0))
        path.addCurve(to: CGPoint(x: 63.0, y: 54.0),
                      control1: CGPoint(x: 112.4, y: 36.9),
                      control2: CGPoint(x: 89.7, y: 60.8))
        path.addCurve(to: CGPoint(x: 27.0, y: 53.0),
                      control1: CGPoint(x: 52.3, y: 51.3),
                      control2: CGPoint(x: 42.2, y: 42.0))
        path.addCurve(to: CGPoint(x: 5.0, y: 40.0),
                      control1: CGPoint(x: 9.6, y: 65.6),
                      control2: CGPoint(x: 5.4, y: 58.3))
        path.addCurve(to: CGPoint(x: 36.0, y: 12.0),
                      control1: CGPoint(x: 4.6, y: 22.0),
                      control2: CGPoint(x: 19.1, y: 9.7))
        path.addCurve(to: CGPoint(x: 89.0, y: 14.0),
                      control1: CGPoint(x: 59.2, y: 15.2),
                      control2: CGPoint(x: 61.9, y: 31.5))
        path.addCurve(to: CGPoint(x: 104.0, y: 15.0),
                      control1: CGPoint(x: 95.3, y: 10.0),
                      control2: CGPoint(x: 100.9, y: 6.9))
        
        let pathRect = path.boundingRect
        path = path.offsetBy(dx: rect.minX - pathRect.minX, dy: rect.minY - pathRect.minY)
        
        let scale: CGFloat = rect.width / pathRect.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        path = path.applying(transform)
        
        
        return path
            .offsetBy(dx: rect.minX - path.boundingRect.minX, dy: rect.midY - path.boundingRect.midY)
    }
}

// Striped pattern for cards
extension CGImage {

    static func generateStripePattern(
        colors: (UIColor, UIColor) = (.white, .red),
        width: CGFloat = 3,
        ratio: CGFloat = 3) -> CGImage? {

    let context = CIContext()
    let stripes = CIFilter.stripesGenerator()
    stripes.color0 = CIColor(color: colors.0)
    stripes.color1 = CIColor(color: colors.1)
    stripes.width = Float(width)
    stripes.center = CGPoint(x: 1 - (width * ratio), y: 0)
    let size = CGSize(width: width, height: 1)

    guard
        let stripesImage = stripes.outputImage,
        let image = context.createCGImage(stripesImage, from: CGRect(origin: .zero, size: size))
    else { return nil }
    return image
  }
}

extension Shape {

    func stripes(color: UIColor) -> AnyView {
        guard
            let stripePattern = CGImage.generateStripePattern(colors: (.white, color))
        else { return AnyView(self)}

        return AnyView(self.fill(ImagePaint(
            image: Image(decorative: stripePattern, scale: 1.5)))
            .scaleEffect(1.5)
            .clipShape(self))
    }
}

struct AnyShape: Shape {
    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }

    private let _path: (CGRect) -> Path
}
