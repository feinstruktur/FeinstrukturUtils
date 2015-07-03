//
//  CoreGraphics+ext.swift
//  swift-utils
//
//  Created by Sven Schmidt on 04/03/2015.
//
//

import Foundation
import CoreGraphics


// MARK: - GCPoint

public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func +(lhs: CGPoint, rhs: (CGFloat, CGFloat)) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.0, y: lhs.y + rhs.1)
}

public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func -(lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
}

public func -(lhs: CGPoint, rhs: (CGFloat, CGFloat)) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.0, y: lhs.y - rhs.1)
}

public func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func +=(inout lhs: CGPoint, rhs: CGPoint) {
    lhs.x += rhs.x
    lhs.y += rhs.y
}

public func -=(inout lhs: CGPoint, rhs: CGPoint) {
    lhs.x -= rhs.x
    lhs.y -= rhs.y
}

extension CGPoint {
    public init(size: CGSize) {
        self = CGPoint(x: size.width, y: size.height)
    }
}


// MARK: - CGSize

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: CGSize, rhs: (CGFloat, CGFloat)) -> CGSize {
    return CGSize(width: lhs.width + rhs.0, height: lhs.height + rhs.1)
}

public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
}


// MARK: - CGRect

public extension CGRect {
    
    func withPadding(x x: CGFloat, y: CGFloat) -> CGRect {
        return CGRect(origin: self.origin - (x,y), size: self.size + 2 * (x,y))
    }
    
    func createTiles(columns columns: Int, rows: Int) -> [CGRect] {
        let w = self.width / CGFloat(columns)
        let h = self.height / CGFloat(rows)
        var current: (CGFloat, CGFloat) = (self.origin.x, self.origin.y)
        var tiles = [CGRect]()
        for _ in 0..<rows {
            current.0 = self.origin.x
            for _ in 0..<columns {
                let r = CGRect(x: current.0, y: current.1, width: w, height: h)
                tiles.append(r)
                current.0 += w
            }
            current.1 += h
        }
        return tiles
    }
    
    var center: CGPoint {
        get {
            return self.origin + CGPoint(x: self.width / 2.0, y: self.height / 2.0)
        }
    }

}


// MARK: - Generic

public func *(lhs: (CGFloat, CGFloat), rhs: CGFloat) -> (CGFloat, CGFloat) {
    return (lhs.0 * rhs, lhs.1 * rhs)
}

public func *(lhs: CGFloat, rhs: (CGFloat, CGFloat)) -> (CGFloat, CGFloat) {
    return rhs * lhs
}

