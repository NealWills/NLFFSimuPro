//
//  ExtFont.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/9.
//

import Foundation

import UIKit


struct Font {
    
    private static let defaultFont = UIFont.systemFont(ofSize: App.scale(16))
    
    enum CustomFontName: String {
//        case Alibaba_PuHuiTi_H = "Alibaba-PuHuiTi-H"
//        case DINAlternate_Bold = "DINAlternate-Bold"
        case LoverEyes = "AaAEDYJSDBDYNon-CommercialUse"
    }

    private enum PingFangFontName: String {
        case Medium = "PingFangSC-Medium"
        case Regular = "PingFangSC-Regular"
        case Light = "PingFangSC-Light"
        case Semibold = "PingFangSC-Semibold"
        case Bold = "PingFangSC-Bold"
    }
    
    static func custom(name: CustomFontName, size: CGFloat) -> UIFont {
        return UIFont.init(name: name.rawValue, size: size) ?? defaultFont
    }
    
    static func regular(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func light(_ size: CGFloat) -> UIFont {
        return UIFont(name: PingFangFontName.Light.rawValue, size: size)!
    }
    
    static func medium(_ size: CGFloat) -> UIFont {
        return UIFont(name: PingFangFontName.Medium.rawValue, size: size)!
    }
    
    static func semiBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: PingFangFontName.Semibold.rawValue, size: size)!
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    

}

