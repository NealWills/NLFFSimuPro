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
        
        weak var weakSelf = self
        
        let title = ["关卡", "设置"]
        
        self.tabBar.backgroundColor = Color.clear
        self.tabBar.backgroundImage = UIImage.init()
        
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
        
        UIView.create()
            .set(superView: self.tabBar)
            .set(snp: { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 0, bottom: -40, right: 0))
            })
            .set(backgroundColor: Color.hex("#FFFFFF"))
            .set(layerCornerRadius: App.scale(25))
            .set(shadowColor: Color.hex("#000000"), shadowOffset: CGSize.init(width: -3, height: 0), shadowOpacity: 0.3, shadowRadius: 8)
        
        
        self.tabBar.items?.forEachWithIndex({ tabbarItem, index in
            tabbarItem.title = title[index]
        })
        
        
        
//        self.tabBar.subviews.forEachWithIndex { item, index in
//            print(item, index)
//        }
        
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

extension UITabBarController {
    
    func selectTab(_ index: UInt) {
        self.selectedIndex = Int(index)
    }
}

class MainBaseTabbarController: BaseTabbarController {
    
}

