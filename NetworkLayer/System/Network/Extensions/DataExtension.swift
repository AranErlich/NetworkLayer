//
//  DataExtension.swift
//  Pulse News
//
//  Created by Aran Erlich on 1/16/21.
//

import Foundation

extension Data {
    
    func toDictionary() -> [String:Any]? {
        let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String : Any]
        
        return json
    }
    
    func toArray() -> Any? {
        return try? JSONSerialization.jsonObject(with: self, options: [])
    }
    
    init<T>(from value: T) {
        self = withUnsafePointer(to: value) { (ptr: UnsafePointer<T>) -> Data in
            return Data(buffer: UnsafeBufferPointer(start: ptr, count: 1))
        }
//        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
    
    
}
