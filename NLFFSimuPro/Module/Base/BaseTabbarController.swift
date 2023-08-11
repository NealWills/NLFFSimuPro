//
//  BaseTabbarController.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/8/11.
//

import Foundation
import UIKit

class BaseTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            guard let statusBarStyle = self.selectedViewController?.preferredStatusBarStyle else {
                if #available(iOS 13.0, *) {
                    return .darkContent
                } else {
                    return .default
                }
            }
            return statusBarStyle
        }
    }
}

class MainBaseTabbarController: BaseTabbarController {
    
}

