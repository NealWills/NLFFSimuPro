//
//  ExtColor.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/9.
//

import Foundation
import UIKit

class Color {
    
    static let clear = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0)

    static let white = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
    
    static let black = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    
    /// 占位色
    static let placeHolder = UIColor.init(red: 0.839, green: 0.839, blue: 0.839, alpha: 1.0)
    
}

extension Color {
    
    /// - Parameter hexStr: 字符串颜色 遵循 R\G\B\A 的规则
    /// - Parameter alpha: 传alpha以alpha为主，不传以hexString为主
    /// - Returns: UIColor
    static func hex(_ hexStr: String?, alpha:CGFloat? = -1) -> UIColor {
        
        guard let hexStr0 = hexStr else {
            return UIColor.init(white: 1, alpha: 0)
        }
        
        var hexStr = hexStr0.uppercased().replacingOccurrences(of: "0X", with: "")
        hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        
        var r = 0
        var g = 0
        var b = 0
        var a = 255
//        protocolLabel.customColor[customType] = UIColor.hex(hexString: "#75DBF2")

        if hexStr.count == 1 { // F -> FFFFFF
            let c = Color.HexStringTransToInt(hexStr[0])
            r = c * 16 + c
            b = r
            g = r
        } else if hexStr.count == 2 { // FA -> FAFAFA
            let r1 = Color.HexStringTransToInt(hexStr[0] )
            let r2 = Color.HexStringTransToInt(hexStr[1] )
            r = r1 * 16 + r2
            b = r
            g = r
        } else if hexStr.count < 6 {
            if hexStr.count > 0 {
                let r1 = Color.HexStringTransToInt(hexStr[0] )
                r = r1 * 16 + r1
            }
            if hexStr.count > 1 {
                let g1 = Color.HexStringTransToInt(hexStr[1] )
                g = g1 * 16 + g1
            }
            if hexStr.count > 2 {
                let b1 = Color.HexStringTransToInt(hexStr[2] )
                b = b1 * 16 + b1
            }
            if hexStr.count > 3 {
                let a1 = Color.HexStringTransToInt(hexStr[3] )
                a = a1 * 16 + a1
            }
        } else {
            let r1 = Color.HexStringTransToInt(hexStr[0] )
            let r2 = Color.HexStringTransToInt(hexStr[1] )
            r = r1 * 16 + r2
            
            let g1 = Color.HexStringTransToInt(hexStr[2] )
            let g2 = Color.HexStringTransToInt(hexStr[3] )
            g = g1 * 16 + g2
            
            let b1 = Color.HexStringTransToInt(hexStr[4] )
            let b2 = Color.HexStringTransToInt(hexStr[5] )
            b = b1 * 16 + b2
            
            if hexStr.count >= 8 {
                let a1 = Color.HexStringTransToInt(hexStr[6] )
                let a2 = Color.HexStringTransToInt(hexStr[7] )
                a = a1 * 16 + a2
            }
        }
        
        if var alpha = alpha {
            alpha = alpha > 1.0 ? 1.0 : alpha
            if alpha < 0 {
                return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
            } else {
                return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
            }
        } else {
            return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
        }
        
    }
    
}

fileprivate extension Color {
    
    static func HexStringTransToInt(_ hexStr: String) -> Int {
        switch hexStr.uppercased() {
        case "0":
            return 0
        case "1":
            return 1
        case "2":
            return 2
        case "3":
            return 3
        case "4":
            return 4
        case "5":
            return 5
        case "6":
            return 6
        case "7":
            return 7
        case "8":
            return 8
        case "9":
            return 9
        case "A":
            return 10
        case "B":
            return 11
        case "C":
            return 12
        case "D":
            return 13
        case "E":
            return 14
        case "F":
            return 15
        default:
            return 0
        }
    }
    
}
