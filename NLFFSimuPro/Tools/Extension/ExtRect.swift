//
//  ExtRect.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/8/11.
//

import Foundation

extension CGSize {
    
    static func create<TWidth, THeight>(width: TWidth, height: THeight) -> CGSize {
        guard let dWidth = Double.init("\(width)"),
                let dHeight = Double.init("\(height)")
        else {
            return .zero
        }
        
        return CGSize.init(width: dWidth, height: dHeight)
    }
    
}

extension CGPoint {
    
    static func create<TX, TY>(x: TX, y: TY) -> CGPoint {
        guard let dX = Double.init("\(x)"),
              let dY = Double.init("\(y)")
        else {
            return .zero
        }
        
        return CGPoint.init(x: dX, y: dY)
    }
    
}


extension CGRect {
    
    static func create<TX, TY, TWidth, THeight>(x: TX, y: TY, width: TWidth, height: THeight) -> CGRect {
        guard let dX = Double.init("\(x)"),
                let dY = Double.init("\(y)"),
                let dWidth = Double.init("\(width)"),
                let dHeight = Double.init("\(height)")
        else {
            return .zero
        }
        
        return CGRect.init(x: dX, y: dY, width: dWidth, height: dHeight)
    }
    
}

extension CGRect {
    
    var minX: CGFloat {
        set {
            self = CGRect.init(x: newValue, y: self.origin.y, width: self.size.width, height: self.size.height)
        }
        get {
            return self.origin.x
        }
    }
    
    var minY: CGFloat {
        set {
            self = CGRect.init(x: self.origin.x, y: newValue, width: self.size.width, height: self.size.height)
        }
        get {
            return self.origin.y
        }
    }
    
    var maxX: CGFloat {
        set {
            self = CGRect.init(x: newValue - self.size.width, y: self.origin.y, width: self.size.width, height: self.size.height)
        }
        get {
            return self.origin.x + self.size.width
        }
    }
    
    var maxY: CGFloat {
        set {
            self = CGRect.init(x: self.origin.x, y: newValue - self.size.height, width: self.size.width, height: self.size.height)
        }
        get {
            return self.origin.y + self.size.height
        }
    }
    
    var centerX: CGFloat {
        set {
            self = CGRect.init(x: newValue - self.size.width / 2.0, y: self.origin.y, width: self.size.width, height: self.size.height)
        }
        get {
            return self.origin.x + self.size.width / 2.0
        }
    }
    
    var centerY: CGFloat {
        set {
            self = CGRect.init(x: self.origin.x, y: newValue - self.size.height / 2.0, width: self.size.width, height: self.size.height)
        }
        get {
            return self.origin.y + self.size.height / 2.0
        }
    }
    
}
