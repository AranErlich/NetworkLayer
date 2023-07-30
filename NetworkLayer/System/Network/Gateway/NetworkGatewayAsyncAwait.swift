//
//  NetworkGatewayAsyncAwait.swift
//  NetworkLayer
//
//  Created by Aran Erlich on 21/07/2022.
//

import Foundation

extension NetworkGateway {
    
    /// Performs network request.
    ///
    /// - Parameter:
    ///     - NetworkTarget
    /// - Return:
    ///     - await response with generic result
    static func request<response: Codable>(target: NetworkTarget) async -> Result<response, Error> {
        // Mock Task
        if target.mock, let url = target.urlRequest.url {
            do {
                let data = try getMockData(url: url)
                
                return Self.parseData(data: data)
            } catch {
                return .failure(NetworkError.status(.noContent))
            }
        }
        
        return await dataRequest(urlRequest: target.urlRequest)
    }
    
    // MARK: - helpers
    
    private static func dataRequest<response: Codable>(urlRequest: URLRequest) async -> Result<response, Error> {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            // TODO: - need to debug
            if let error = Self.parseErrorIfNeeded(response: response, data: data) {
                return .failure(error)
            }

            // check for error regardless 200 ok
            return Self.parseData(data: data)
        } catch let error {
            return .failure(NetworkError.underlying(error))
        }
    }
    
    private static func parseErrorIfNeeded(response: URLResponse, data: Data) -> Error? {
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0
        
        // check status code before internal error check
        guard 200 ... 299 ~= statusCode else {
            if statusCode == StatusCode.unauthorized.rawValue {
                return NetworkError.status(.unauthorized)
            } else if let sc = StatusCode(rawValue: statusCode) {
                return NetworkError.status(sc)
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    private static func parseData<response: Codable>(data: Data) -> Result<response, Error> {
        guard let res = NetworkDataParser<response>(data: data)?.result() else {
            let networkError = NetworkError.status(.noContent)
            return .failure(networkError)
        }
        
        return res
    }
}
