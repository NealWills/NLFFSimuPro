//
//  ExString.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/18.
//

import Foundation

extension String {
    
    subscript(_ range: Range<Int>) -> String? {
        if (self.isEmpty) {
            return ""
        }
        let length = self.count;

        var startIndex = range.startIndex > self.count ? self.count : range.startIndex
        startIndex = startIndex < 0 ? 0 : startIndex;
        var endIndex = range.endIndex > self.count ? self.count : range.endIndex
        endIndex = endIndex < 0 ? 0 : endIndex;

        if startIndex >= endIndex {
            return ""
        }

        if startIndex >= length {
            return ""
        }
        if endIndex >= length {
            endIndex = length;
        }

        let startOffset = self.index(self.startIndex, offsetBy: startIndex)
        let endOffset = self.index(self.startIndex, offsetBy: endIndex)

        return String(self[startOffset..<endOffset])
    }
    
    subscript(_ index: Int) -> String {
        if self.count < 1 {
            return ""
        }
        if self.count <= index {
            return ""
        }
        let startOffset = self.index(self.startIndex, offsetBy: index)
        let endOffset = self.index(self.startIndex, offsetBy: index + 1)
        return String(self[startOffset..<endOffset])
    }
    
    func isNullOrEmpty() -> Bool {
        guard let str = self as? String else {
            return true
        }
        if str.isEmpty {
            return true
        }
        return false
    }

    func isNotNullOrEmpty() -> Bool {
        return !self.isNullOrEmpty()
    }

    func trim() -> String {
        var str = self
        if str[0..<1] == " " {
            str = str.nsString().replacingCharacters(in: NSRange.init(location: 0, length: 1), with: "")
        }
        if str[str.count - 1..<str.count] == " " {
            str.nsString().replacingCharacters(in: NSRange.init(location: str.count - 1, length: 1), with: "")
        }
        return str
    }

    func nsString() -> NSString {
        return NSString.init(string: self)
    }
    
}
