//
//  HomeTableMechanismCell.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/18.
//

import Foundation
import UIKit

class HomeTableMechanismCell: BaseTableViewCell {
    
    var titleLabel: UILabel?
    
    var subTitleLabel: UILabel?
    
    var topLine: UIView?
    
    override func initSubView() {
        super.initSubView()
        
        weak var weakSelf = self
      
        self.titleLabel = UILabel.create()
            .set(superView: self.view)
            .set(snp: { make in
                make.leading.equalToSuperview().offset(App.scale(32))
                make.centerY.equalToSuperview()
            })
            .set(textColor: Color.hex("#313131"))
            .set(font: Font.medium(App.scale(14)))
      
        self.subTitleLabel = UILabel.create()
            .set(superView: self.view)
            .set(snp: { make in
                make.leading.equalTo((weakSelf?.titleLabel)!.snp.trailing).offset(App.scale(6))
                make.bottom.equalTo(self.titleLabel!)
            })
            .set(textColor: Color.hex("#313131"))
            .set(font: Font.medium(App.scale(12)))
        
    }
    
    override func setModel(_ model: Any?) {
        super.setModel(model)
        guard let model = model as? LevelMechanismModel else {
            return
        }
        if (model.isValid ?? 0) < 1 {
            self.view?.set(hidden: true)
        } else {
            self.view?.set(hidden: false)
        }
        self.titleLabel?.set(text: model.mechanism)
        self.subTitleLabel?.set(text: model.tactics)
    }
    
    override class func cellHeightWithModel(_ model: Any?) -> CGFloat {
        
        guard let model = model as? LevelMechanismModel else {
            return 0.0001
        }
        if (model.isValid ?? 0) < 1 {
            return 0.0001
        }
        return App.scale(50)
    }
    
}
