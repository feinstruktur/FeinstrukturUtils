//
//  CoreGraphics+ext.swift
//  swift-utils
//
//  Created by Sven Schmidt on 04/03/2015.
//
//

import Foundation
import CoreGraphics


public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

