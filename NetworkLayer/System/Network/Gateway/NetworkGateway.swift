//
//  NetworkGateway.swift
//
//  Created by Aran Erlich on 04/10/2021.
//

import Foundation

class NetworkGateway {
    
    // MARK: - Public functions
    
    static func execute<response: Codable> (target: NetworkTarget, completion: @escaping (Result<response, Error>) -> Void) {
        request(target: target, completion: completion)
    }
    
    static func execute<response: Codable> (target: NetworkTarget) async -> Result<response, Error> {
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
