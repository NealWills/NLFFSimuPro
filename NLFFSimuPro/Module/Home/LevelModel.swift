//
//  LevelModel.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/18.
//

import Foundation

class LevelModel: NSObject, APIDataEncoderProtocol {
    
    // 关卡id
    var id: String?
    
    // 关卡名字
    var level: String?
    
    // 关卡别名
    var levelRemark: String?
    
    // 是否开启
    var isValid: Int?
    
    // 关卡卡片颜色
    var cardColor: String?
    
    // 关卡标题颜色
    var levelColor: String?
    
    // 关卡别名颜色
    var levelRemarkColor: String?
    
    // 关卡机制列表
    var mechanismList: [LevelMechanismModel]?

    var cellModel: LevelCellModel = .defaultModel()
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case level
        case levelRemark
        case isValid
        case mechanismList
        case cardColor
        case levelColor
        case levelRemarkColor
        
    }
    
    func externKeyEncoder(with dic: [String : Any]) {
        
    }
    
}


class LevelCellModel {
    
    var isExpend: Int
    
    init(isExpend: Int) {
        self.isExpend = isExpend
    }
    
    class func defaultModel() -> LevelCellModel {
        let model = LevelCellModel.init(
            isExpend: 0
        )
        return model
    }
    
}


