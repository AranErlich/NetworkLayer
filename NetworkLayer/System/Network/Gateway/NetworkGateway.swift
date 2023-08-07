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
    
    static func getImageData(from url: URL) async -> Data? {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        let urlSession = URLSession(configuration: config)
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            
            return data
        } catch let error {
            print(error)
            
            return nil
        }
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
