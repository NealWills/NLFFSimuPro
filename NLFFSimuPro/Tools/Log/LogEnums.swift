import Foundation

public enum Level: Int {
    case Trace = 0
    case Debug = 1
    case Info = 2
    case Warning = 3
    case Error = 4
}

public enum Open {
    case Open, Close
}

public enum ApiMethod {
    case POST, GET, Delete
}

public enum ApiProcess {
    case Request, Response
}

struct logMark {
    
    var Trace = ""
    
    var Debug = ""
    
    var Info = ""
    
    var Warning = ""
    
    var Error = ""
    
    init(markTrace: String?=nil, markDebug: String?=nil, markInfo: String?=nil, markWarning: String?=nil, markError: String?=nil) {
        

        self.Trace = markTrace ?? ""
        self.Debug = markDebug ?? ""
        self.Info = markInfo ?? ""
        self.Warning = markWarning ?? ""
        self.Error = markError ?? ""
    
    }

}
