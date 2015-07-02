//
//  FSButton.swift
//  FSButton
//
//  Created by Sven A. Schmidt on 19/01/2015.
//  Copyright (c) 2015 feinstruktur. All rights reserved.
//

import UIKit
import QuartzCore


public let FSButtonDefaultColor = UIColor(red:0, green: 0.502, blue:1, alpha:1)
let DefaultText = "Button"
let DefaultFontSize: CGFloat = 14
let DefaultFontName = "Helvetica"
let DefaultTextColor = FSButtonDefaultColor
let DefaultFillColor = UIColor.clearColor()
let DefaultBorderColor = FSButtonDefaultColor
let DefaultBorderWidth: CGFloat = 1
let DefaultCornerRadius: CGFloat = 5


func convertToUIFont(font: AnyObject!, size: CGFloat) -> UIFont! {
    if let name = font as? String {
        return UIFont(name: name, size: size)
    } else {
        switch CFGetTypeID(font) {
        case CTFontGetTypeID():
            let name = CTFontCopyPostScriptName(font as! CTFont)
            return UIFont(name: name as String, size: size)
        case CGFontGetTypeID():
            let name = CGFontCopyPostScriptName(font as! CGFont)
            return UIFont(name: name as String, size: size)
        default:
            return UIFont.systemFontOfSize(size)
        }
    }
}

extension CATextLayer {
    public func sizeToFit() {
        if let string = self.attributedString {
            let size = string.size() + CGSize(width: 0, height: 2)
            self.frame = CGRect(origin: self.frame.origin, size: size)
        }
    }

    var uifont: UIFont! {
        get {
            return convertToUIFont(self.font, size: self.fontSize)
        }
    }

    var attributedString: NSAttributedString! {
        get {
            if self.string == nil {
                return nil
            }
            if let s = self.string as? NSAttributedString {
                return s
            } else {
                return NSAttributedString(string: self.string as! String!, attributes: [NSFontAttributeName: self.uifont])
            }
        }
    }
}


@IBDesignable
public class FSButton: UIControl {
    
    @IBInspectable public var text: String = DefaultText {
        didSet {
            self.textLayer.string = text
            self.updateLayers()
        }
    }

    @IBInspectable public var fontSize: CGFloat = DefaultFontSize {
        didSet {
            self.textLayer.fontSize = fontSize
            self.updateLayers()
        }
    }
    
    @IBInspectable public var fontName: String = DefaultFontName {
        didSet {
            self.textLayer.font = fontName
            self.updateLayers()
        }
    }
    
    @IBInspectable public var textColor: UIColor = DefaultTextColor {
        didSet {
            self.textLayer.foregroundColor = textColor.CGColor
            self.updateLayers()
        }
    }
    
    @IBInspectable public var fillColor: UIColor = DefaultFillColor {
        didSet {
            self.mainLayer.fillColor = fillColor.CGColor
            self.updateLayers()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = DefaultBorderColor {
        didSet {
            self.mainLayer.strokeColor = borderColor.CGColor
            self.updateLayers()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = DefaultBorderWidth {
        didSet {
            self.mainLayer.lineWidth = borderWidth
            self.updateLayers()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = DefaultCornerRadius {
        didSet {
            self.updateLayers()
        }
    }
    
    @IBInspectable public var pinned: Bool = true
    
    let mainLayer = CAShapeLayer()
    let textLayer = CATextLayer()
    var previousLocation = CGPoint()
    var touched = false
    var highlightedObserver: Observer!
    var enabledObserver: Observer!
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
            self.setNeedsDisplay()
        }
    }

    public var size: CGSize {
        get {
            return self.frame.size
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    func setup() {
        self.highlightedObserver = Observer(observedObject: self, keyPath: "highlighted") { _ in
            self.updateColors(self.enabled, highlighted: self.highlighted)
        }
        self.enabledObserver = Observer(observedObject: self, keyPath: "enabled") { _ in
            self.updateColors(self.enabled, highlighted: self.highlighted)
        }
        
        self.layer.addSublayer(self.mainLayer)
        self.layer.addSublayer(self.textLayer)

        self.setDefaults()
        self.updateLayers()
    }

    func setDefaults() {
        self.textLayer.contentsScale = UIScreen.mainScreen().scale
        self.textLayer.alignmentMode = kCAAlignmentCenter
        self.textLayer.string = DefaultText
        self.textLayer.fontSize = DefaultFontSize
        self.textLayer.font = DefaultFontName
        self.textLayer.foregroundColor = DefaultTextColor.CGColor
        self.mainLayer.fillColor = DefaultFillColor.CGColor
        self.mainLayer.strokeColor = DefaultBorderColor.CGColor
        self.mainLayer.lineWidth = DefaultBorderWidth
    }
    
    func updateLayers() {
        self.textLayer.sizeToFit()
        let offset = CGPoint(size: self.frame.size - self.textLayer.frame.size)/2
        self.textLayer.frame.origin = offset

        self.mainLayer.frame = self.bounds
        self.mainLayer.path = {
            let padding = -self.borderWidth/2
            let rect = CGRect(origin: CGPointZero, size: self.size).withPadding(x: padding, y: padding)
            return UIBezierPath(roundedRect: rect, cornerRadius: self.cornerRadius).CGPath
        }()

        self.setNeedsDisplay()
    }
    
}


// MARK: - Helpers
extension FSButton {
    
    func colorAnim(keypath: String, from: CGColor!, to: CGColor!) -> CABasicAnimation {
        let flash = CABasicAnimation(keyPath: keypath)
        flash.fromValue = from
        flash.toValue = to
        flash.duration = 0.2
        return flash
    }
    
    func change(layer: CALayer, color: CGColor, keypath: String) {
        let initial = layer.valueForKeyPath(keypath) as! CGColor
        layer.addAnimation(self.colorAnim(keypath, from: initial, to: color), forKey: keypath)
        layer.setValue(color, forKeyPath: keypath)
    }
    
    func updateColors(enabled: Bool, highlighted: Bool) {
        if enabled {
            let fill = (highlighted ? self.textColor : self.fillColor).CGColor
            let text = { Void -> CGColor in
                let c = highlighted ? self.fillColor : self.textColor
                // want to make sure the text stays visible when we invert in case of a clear fill color
                if c == UIColor.clearColor() {
                    return UIColor.whiteColor().CGColor
                } else {
                    return c.CGColor
                }
                }()
            self.change(self.mainLayer, color: fill, keypath: "fillColor")
            self.change(self.mainLayer, color: self.borderColor.CGColor, keypath: "strokeColor")
            self.change(self.textLayer, color: text, keypath: "foregroundColor")
        } else {
            let gray = UIColor.lightGrayColor().CGColor
            self.change(self.mainLayer, color: self.fillColor.CGColor, keypath: "fillColor")
            self.change(self.mainLayer, color: gray, keypath: "strokeColor")
            self.change(self.textLayer, color: gray, keypath: "foregroundColor")
        }
    }
    
}


// UIView overrides
extension FSButton {
    
    public override func intrinsicContentSize() -> CGSize {
        return self.textLayer.frame.size + CGSize(width: 20, height: 10)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.updateLayers()
    }
    
}


// MARK: - Touch handling
extension FSButton {

    public override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        self.previousLocation = touch.locationInView(self.superview)        
        if self.frame.contains(self.previousLocation) {
            self.touched = true
        }
        return self.touched
    }

    public override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        if !self.pinned {
            let location = touch.locationInView(self.superview)
            let delta = location - self.previousLocation
            self.previousLocation = location
            self.frame.offset(dx: delta.x, dy: delta.y)
        }

        return true
    }

    public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        self.touched = false
    }
    
}
