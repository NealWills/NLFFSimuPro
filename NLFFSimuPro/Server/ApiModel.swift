//
//  ApiModel.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/18.
//

import Foundation


struct APIModel {
    var msg: String
    var status: Int
    var dicData: [String: Any]?
    var strData: String?
    var intData: Int?
    var arrData: [Any]?
    var data: Any?
    var code: Int?

    init(msg: String, status: Int) {
        self.msg = msg
        self.status = status
    }

    init(with dic: [String: Any]) {
        self.msg = dic["msg"] as? String ?? ""
        if let status = dic["status"] as? Int {
            self.code = status

            if status >= 0 {
                self.status = 0
            } else {
                self.status = status
            }
        } else {
            self.status = -404
        }
        if let dicData = dic["data"] as? [String: Any] {
            self.dicData = dicData
        }
        if let strData = dic["data"] as? String {
            self.strData = strData
        }
        if let intData = dic["data"] as? Int {
            self.intData = intData
        }
        if let arrData = dic["data"] as? [Any] {
            self.arrData = arrData
        }

        self.data = dic["data"]
    }

    public func description() -> String {
        var info = ""
        info.append("msg: " + self.msg)
        info.append("\n  ----------------------------")
        info.append("\n  status: " + "\(self.status)")
        info.append("\n  ----------------------------")
        info.append("\n  dicData: \n  " + "\(String(describing: self.dicData ?? [:]))")
        info.append("\n  - - - - - - - - - - - - - - -")
        info.append("\n  strData: \n  " + "\(String(describing: self.strData ?? ""))")
        info.append("\n  - - - - - - - - - - - - - - -")
        info.append("\n  intData: \n  " + "\(self.intData ?? 0)")
        info.append("\n  - - - - - - - - - - - - - - -")
        info.append("\n  arrData: \n  " + "\(String(describing: self.arrData ?? []))")
        info.append("\n  - - - - - - - - - - - - - - -")
        info.append("\n  data: \n  " + "\(String(describing: self.data ?? ""))")
        info.append("\n  - - - - - - - - - - - - - - -")
        return info
    }

}
