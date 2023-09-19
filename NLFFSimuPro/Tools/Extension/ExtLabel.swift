//
//  ExtLabel.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/18.
//

import Foundation
import UIKit

extension UILabel {
    
    @discardableResult
    func set(font: UIFont?) -> Self {
        self.font = font ?? .systemFont(ofSize: App.scale(14))
        return self
    }
    
    @discardableResult
    func set(textColor: UIColor?) -> Self {
        self.textColor = textColor ?? Color.clear
        return self
    }
    
    @discardableResult
    func set(text: String?) -> Self {
        self.text = text ?? ""
        return self
    }
}
