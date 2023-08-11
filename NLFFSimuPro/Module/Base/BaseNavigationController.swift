//
//  BaseNavigationController.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/8/11.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            guard let statusBarStyle = self.viewControllers.last?.preferredStatusBarStyle else {
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
