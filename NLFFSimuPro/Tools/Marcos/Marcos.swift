//
//  Marcos.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/9.
//

import UIKit
import Foundation

class App {
    
    class func scale(_ length: CGFloat) -> CGFloat {
        let scale = UIScreen.main.bounds.width / 375.0
        return length * scale
    }
    
    class func bounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
    class func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    class func statusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    class func navigationbarHeight() -> CGFloat {
        return statusBarHeight() + 44
    }
    
    class func safeBottomHeight() -> CGFloat {
        return statusBarHeight() > 20 ? 34 : 0
    }
    
    class func tabbarHeight() -> CGFloat {
        return safeBottomHeight() + 49
    }
    
}
