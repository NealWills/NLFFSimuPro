//
//  ExtImage.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/8/11.
//

import Foundation
import UIKit

extension UIImage {
    
    class func create(name: String?) -> UIImage {
        guard let name = name else {
            return UIImage.init()
        }
        guard let image = UIImage.init(named: name) else {
            return UIImage.init()
        }
        return image
    }
}
