//
//  LevelMechanismModel.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/18.
//

import Foundation

class LevelMechanismModel: NSObject, APIDataEncoderProtocol {
    
    // 机制名字
    var mechanism: String?
    
    // 攻略打法
    var tactics: String?
    
    // 是否开启
    var isValid: Int?
    
    
}
