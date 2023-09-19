//
//  ExtButton.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/8/11.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

extension UIButton {
    
    func add(tap action: @escaping ()->(), disposeBag: DisposeBag?) -> Self {
        self.rx.tap.subscribe { _ in
            action()
        }.disposed(by: disposeBag ?? .init())
        return self
    }
    
    func set(image: UIImage?, state: UIControl.State? = .normal) -> Self {
        self.setImage(image, for: state ?? .normal)
        return self
    }
    
}
