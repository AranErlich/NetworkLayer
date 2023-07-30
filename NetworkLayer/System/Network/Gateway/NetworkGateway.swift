//
//  NetworkGateway.swift
//
//  Created by Aran Erlich on 04/10/2021.
//

import Foundation

class NetworkGateway {
    
    // MARK: - Public functions
    
    static func execute<response: Codable, error: Error> (target: NetworkTarget, completion: @escaping (Result<response, error>) -> Void) {
        request(target: target, completion: completion)
    }
    
    static func execute<response: Codable, error: Error> (target: NetworkTarget) async -> Result<response, error> {
        return await request(target: target)
    }
    
    // MARK: - helpers
    
    static func getMockData(url: URL) throws -> Data {
        do {
            let data = try Data(contentsOf: url)
            return data
        }
        catch let error {
            throw error
        }
    }
    
}
