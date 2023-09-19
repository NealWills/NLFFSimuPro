//
//  ExtArray.swift
//  NLFFSimuPro
//
//  Created by Neal on 2023/9/2.
//

import Foundation

extension Array {
    
    @discardableResult
    public mutating func set(append unit: Element) -> Self {
        self.append(unit)
        return self
    }
    
    
    @inlinable public func forEachWithIndex(_ body: (Element, Int) throws -> Void) rethrows {
        
        var i = 0
        try self.forEach { item in
            do {
                let _ = try body(item, i)
                i = i + 1
            } catch let error {
                throw error
            }
        }
        
    }
    
    @inlinable public func mapWithIndex<T>(_ transform: (Element, Int) throws -> T) rethrows -> [T] {
        var i = 0
        let array = try self.map { item in
            do {
                let newItem = try transform(item, i) 
                i = i + 1
                return newItem
            } catch let error {
                throw error
            }
        }
        return array
    }
    
}
