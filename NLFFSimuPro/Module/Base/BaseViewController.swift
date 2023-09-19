//
//  BaseViewController.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/8/11.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    public var disposeBag: DisposeBag {
        get {
            
            guard let bag = _disposeBag else {
                _disposeBag = .init()
                return _disposeBag ?? .init()
            }
            return _disposeBag ?? .init()
        }
    }

    fileprivate var _disposeBag: DisposeBag?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(white: 1, alpha: 1)
    }
    
    deinit {
        _disposeBag = nil
    }
    
}
