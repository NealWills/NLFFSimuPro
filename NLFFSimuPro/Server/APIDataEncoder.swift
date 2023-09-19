//
//  APIDataEncoder.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/9.
//

import Foundation




enum APIDataEncoderError: Error {
    case decodeError(status: Int, msg: String)
}

protocol APIDataEncoderProtocol: Codable {
    func externKeyEncoder(with dic: [String: Any])

    func encodeModel() -> [String: Any]

}


extension APIDataEncoderProtocol where Self: APIDataEncoderProtocol {
    func externKeyEncoder(with dic: [String: Any]) {
        
    }
    
    func encodeModel() -> [String: Any] {

        var params = [String: Any]()

        let mirror = Mirror.init(reflecting: self)
        _ = mirror.children.compactMap { property in
            params[property.label ?? ""] = property.value
        }

        return params
    }
}


class APIDataEncoder: NSObject {

    public class func model<ModelType: APIDataEncoderProtocol>(with dic: Dictionary<String, Any>?, modelType: ModelType.Type) throws -> ModelType {

        do {
            let data = try JSONSerialization.data(withJSONObject: dic ?? [:], options: [])
            let model = try JSONDecoder.init().decode(modelType, from: data)
            model.externKeyEncoder(with: dic ?? [:])
            return model
        } catch _ {
//            Log.Error("该数据无法解析 [\(#file):\(#line)]", error, "\(modelType)")
            throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
            
        }

    }

    public class func arrModel<ModelType: APIDataEncoderProtocol>(with arr: [Dictionary<String, Any>]?, modelType: ModelType.Type) throws -> [ModelType] {
        guard let arr = arr else {
            throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
        }
        do {
            return try arr.map {
                do {
                    return try self.model(with: $0, modelType: modelType)
                } catch {
                    throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
                }
            }
        } catch _ {
//            Log.Error("该数据无法解析 [\(#file):\(#line)]", error, "\(modelType)")
            throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
        }
    }

    public class func model<ModelType: APIDataEncoderProtocol>(with str: String?, modelType: ModelType.Type) throws -> ModelType {
        let data = str?.data(using: .utf8)
        var dic:[String:Any]?
        if data == nil {
            throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
        }
        do {
            dic = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any]
        } catch _ {
//            Log.Error("该数据无法解析 [\(#file):\(#line)]", error, "\(modelType)")
            throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
        }
        do {
            let model = try JSONDecoder.init().decode(modelType, from: data!)
            model.externKeyEncoder(with: dic ?? [:])
            return model
        } catch _ {
//            Log.Error("该数据无法解析 [\(#file):\(#line)]", error, "\(modelType)")
            throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
        }
    }

     public class func arrModel<ModelType: APIDataEncoderProtocol>(with str: String?, modelType: ModelType.Type) throws -> [ModelType] {
        let data = str?.data(using: .utf8)
        var arrDic:[[String:Any]]?
        if data == nil {
            throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
        }
        do {
            arrDic = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String : Any]]
        } catch _ {
//            Log.Error("该数据无法解析 [\(#file):\(#line)]", error, "\(modelType)")
            throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
        }
        do {
           return try self.arrModel(with: arrDic, modelType: ModelType.self)
        } catch _ {
//            Log.Error("该数据无法解析 [\(#file):\(#line)]", error, "\(modelType)")
            throw APIDataEncoderError.decodeError(status: -1, msg: "该数据无法解析 [\(#file):\(#line)]")
        }
    }



}


