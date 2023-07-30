//
//  DecodableExtension.swift
//
//  Created by Aran Erlich on 04/10/2021.
//

import Foundation

extension Decodable {
    
    public static func parse(data: Data) throws -> Self {
        let jsonDecoder = JSONDecoder()
        
        do {
            let value = try jsonDecoder.decode(Self.self, from: data)
            return value
        } catch let error {
            print("Parsing Failure - \(error)")
            throw error
        }
    }
    
}
