import Foundation

struct LogManager {

    
    static fileprivate var _open:Open = .Close
    static var open:Open! {
        set {
            _open = newValue
        }
        get {
            return _open
        }
    }
    
    
    static var _minimunLevel: Level = .Trace
    static var minimunLevel: Level! {
        set {
            _minimunLevel = newValue
        }
        get {
            return _minimunLevel
        }
    }
    
    static var mark = logMark.init()
    
    /// 核心
    static fileprivate func LogBase(_ level: String, _ items: [Any], fileName: String = #file, line: Int = #line) {
        
        if self.open == .Close {
            return
        }
        
        //获取时间
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss.SSS"
        let strNowTime = timeFormatter.string(from: date as Date) as String
        
        //获取文件名
        var arrFileName = fileName.components(separatedBy: "/")
        arrFileName = (arrFileName.last?.components(separatedBy: "."))!
        
        print("")
        print("╔ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═")
        print("  \(strNowTime)", "[\(level)]", "[" + (arrFileName.first ?? "File") + ": \(line)]")
        
        for item in items {
            print(" ", item)
        }
        
        print("╚ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═")
    }
    
    /// api相关日志
    static fileprivate func LogApi(api: String, method: ApiMethod, process: ApiProcess, level: String, _ items: [Any], fileName: String = #file, line: Int = #line) {
        
        if self.open == .Close {
            return
        }
        
        //获取时间
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss.SSS"
        let strNowTime = timeFormatter.string(from: date as Date) as String
        
        //获取文件名
        var arrFileName = fileName.components(separatedBy: "/")
        arrFileName = (arrFileName.last?.components(separatedBy: "."))!
        
        print("")
        print("╔ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═")
        print("  \(strNowTime)", "[\(level)]", "[" + (arrFileName.first ?? "File") + ": \(line)]")
        
        let dProcess = process == .Request ? " →→ →→ " : " ←← ←← "
        print(" ", "[\(method)]", dProcess, "[..\(api)]")
        for item in items {
            print(" ", item)
        }
        
        
        print("╚ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═ ═")
    }
}

//MARK:- 设置标志
extension LogManager {
    static func setMark(markTrace: String?=nil, markDebug: String?=nil, markInfo: String?=nil, markWarning: String?=nil, markError: String?=nil) {
        self.mark = logMark.init(markTrace: markTrace, markDebug: markDebug, markInfo: markInfo, markWarning: markWarning, markError: markError)
    }
}

//MARK:- 模式日志
extension LogManager {
    
    static func LevelLog(_ items: [Any?], fileName: String = #file, line: Int = #line, level: Level) {
        if level.rawValue < self.minimunLevel.rawValue {
            return
        }

        var markLevel = mark.Trace + "\(Level.Trace)" + mark.Trace
        switch level {
        case .Trace:
            markLevel = mark.Trace + "\(Level.Trace)" + mark.Trace
            break
        case .Debug:
            markLevel = mark.Debug + "\(Level.Debug)" + mark.Debug
            break
        case .Info:
            markLevel = mark.Info + "\(Level.Info)" + mark.Info
            break
        case .Warning:
            markLevel = mark.Warning + "\(Level.Warning)" + mark.Warning
            break
        case .Error:
            markLevel = mark.Error + "\(Level.Error)" + mark.Error
            break
        }
        
        LogBase(markLevel, items as [Any], fileName: fileName, line: line)
    }
    
}

//MARK:- 普通日志
extension LogManager {
    static func Log(_ items: [Any?], level: Level?=nil, fileName: String = #file, line: Int = #line) {
        
        if (level?.rawValue ?? 2) < self.minimunLevel.rawValue {
            return
        }
        
        let levelL = "\(level ?? .Info)"
        LogBase("\(levelL)", items as [Any], fileName: fileName, line: line)
    }
}

//MARK:- API日志
extension LogManager {
    static func API(api: String, method: ApiMethod, process: ApiProcess, _ items: [Any], level: Level?=nil, fileName: String = #file, line: Int = #line) {
        
        
        if (level?.rawValue ?? 2) < self.minimunLevel.rawValue {
            return
        }
        let levelL = "\(level ?? .Info)"
        
        LogApi(api: api, method: method, process: process, level: levelL, items, line: line)
    }
}



