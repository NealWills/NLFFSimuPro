//
//  HomeTableHeaderCell.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/18.
//

import Foundation
import UIKit

class HomeTableHeaderCell: BaseTableViewCell {
    
    var cardView: UIView?
    
    var titleLabel: UILabel?
    var subTitleLabel: UILabel?
    
    override func initSubView() {
        super.initSubView()
        
        self.cardView = UIView.create()
            .set(superView: self.view)
            .set(snp: { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: App.scale(60), left: App.scale(32), bottom: App.scale(16), right: App.scale(32)))
            })
            .set(layerCornerRadius: App.scale(10))
            .set(shadowColor: Color.hex("#000000"), shadowOffset: CGSize.create(width: -5, height: 5), shadowOpacity: 0.1, shadowRadius: 6)
        
        self.titleLabel = UILabel.create()
            .set(superView: self.cardView)
            .set(snp: { make in
                make.leading.equalToSuperview().offset(App.scale(16))
                make.bottom.equalToSuperview().offset(-App.scale(12))
            })
            .set(textColor: Color.black)
            .set(font: Font.custom(name: .LoverEyes, size: App.scale(24)))
        
        self.subTitleLabel = UILabel.create()
            .set(superView: self.cardView)
            .set(snp: { make in
                make.leading.equalToSuperview().offset(App.scale(16))
                make.bottom.equalToSuperview().offset(-App.scale(45))
            })
            .set(textColor: Color.black)
            .set(font: Font.regular(App.scale(14)))
        
    }
    
    override func setModel(_ model: Any?) {
        super.setModel(model)
        guard let model = model as? LevelModel else {
            return
        }
        if (model.isValid ?? 0) < 1 {
            self.view?.set(hidden: true)
        } else {
            self.view?.set(hidden: false)
        }
        
        self.cardView?.set(backgroundColor: Color.hex(model.cardColor))
            .set(shadowColor: Color.hex(model.cardColor), shadowOffset: CGSize.create(width: -8, height: 8), shadowOpacity: 0.5, shadowRadius: 12)
        self.titleLabel?.set(text: model.level).set(textColor: Color.hex(model.levelColor))
        self.subTitleLabel?.set(text: model.levelRemark).set(textColor: Color.hex(model.levelRemarkColor))
        
    }
    
    override class func cellHeightWithModel(_ model: Any?) -> CGFloat {
        
        guard let model = model as? LevelModel else {
            return 0.0001
        }
        if (model.isValid ?? 0) < 1 {
            return 0.0001
        }
        return App.scale(200)
    }
    
}
