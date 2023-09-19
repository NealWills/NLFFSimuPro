//
//  ExtView.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/8/11.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import SnapKit

extension UIView {
    
    @discardableResult
    class func create(frame: CGRect? = .zero) -> Self {
        let view = Self.init(frame: frame ?? .zero)
        
        return view
    }
    
    @discardableResult
    func set(superView: UIView?) -> Self {
        guard let superView = superView else {
            return self
        }
        superView.addSubview(self)
        return self
    }
    
    @discardableResult
    func set(backgroundColor: UIColor?) -> Self {
        guard let backgroundColor = backgroundColor else {
            return self
        }
        self.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func set(clipToBounds: Bool?) -> Self {
        self.clipsToBounds = clipToBounds ?? false
        return self
    }
    
    @discardableResult
    func set(layerCornerRadius: CGFloat?) -> Self {
        self.layer.cornerRadius = layerCornerRadius ?? 0
        return self
    }
    
    @discardableResult
    func set(shadowColor: UIColor?, shadowOffset: CGSize?, shadowOpacity: CGFloat?, shadowRadius: CGFloat?) -> Self {
        self.layer.shadowColor = (shadowColor ?? .clear).cgColor
        self.layer.shadowOffset = shadowOffset ?? .zero
        self.layer.shadowOpacity = Float((shadowOpacity ?? 0))
        self.layer.shadowRadius = (shadowRadius ?? 0)
        return self
    }
    
    @discardableResult
    func set(frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    @discardableResult
    func set(snp: (_ make: ConstraintMaker) -> Void)  -> Self {
        self.snp.makeConstraints(snp)
        return self
    }
    
    @discardableResult
    func set(remakeSnp: (_ make: ConstraintMaker) -> Void)  -> Self {
        self.snp.remakeConstraints(remakeSnp)
        return self
    }
    
    @discardableResult
    func set(removeSnp: Int)  -> Self {
        self.snp.removeConstraints()
        return self
    }
    
    @discardableResult
    func set(hidden: Bool)  -> Self {
        self.isHidden = hidden
        return self
    }
    
    
    
}

extension UIView {
    
    
    enum TapGesStyle {
        case singleTap
        case doubleTap
    }
    
    func removeAllGes() -> Self {
        self.gestureRecognizers?.removeAll()
        return self
    }
    
    @discardableResult
    func add(gesAction:@escaping ()->(), gesStyle: UIView.TapGesStyle, disposeBag: DisposeBag?) -> Self {
        
        guard let disposeBag = disposeBag else {
            return self
        }
        
        var ges: UIGestureRecognizer?
        
        switch gesStyle {
        case .singleTap:
            let gestureRecognizers = UITapGestureRecognizer.init()
            gestureRecognizers.numberOfTapsRequired = 1
            ges = gestureRecognizers
        case .doubleTap:
            let gestureRecognizers = UITapGestureRecognizer.init()
            gestureRecognizers.numberOfTapsRequired = 2
            ges = gestureRecognizers
        }
        
        guard let gestureRecognizers = ges else {
            return self
        }
        ges?.rx.event.asObservable().subscribe { [weak self] event in
            self?.addGesAction(gesAction, event: event)
        }.disposed(by: disposeBag)
        
        self.addGestureRecognizer(gestureRecognizers)

        return self
    }
    
    fileprivate func addGesAction(_ action: @escaping ()->(), event: UIGestureRecognizer?) {
        guard let event = event else {
            return
        }
        if event.state == .ended {
            action()
        }
    }
    
}
