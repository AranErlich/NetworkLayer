//
//  CodableExtension.swift
//  Pulse News
//
//  Created by Aran Erlich on 1/26/21.
//

import Foundation

extension Encodable {
    
    func toData() -> Data? {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(self)
        
        return data
    }
    
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
}
