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
    static func request<response: Codable, error: Error>(target: NetworkTarget) async -> Result<response, error> {
        // Mock Task
        if target.mock, let url = target.urlRequest.url {
            do {
                let data = try getMockData(url: url)
                
                return Self.parseData(data: data)
            } catch {
                return .failure(NetworkError.status(.noContent) as! error)
            }
        }
        
        return await dataRequest(urlRequest: target.urlRequest)
    }
    
    // MARK: - helpers
    
    private static func dataRequest<response: Codable, error: Error>(urlRequest: URLRequest) async -> Result<response, error> {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            // TODO: - need to debug
            if let error = Self.parseErrorIfNeeded(response: response, data: data, e: error.self) {
                return .failure(error)
            }

            // check for error regardless 200 ok
            return Self.parseData(data: data)
        } catch let error {
            return .failure(NetworkError.underlying(error) as! error)
        }
    }
    
    private static func parseErrorIfNeeded<error: Error>(response: URLResponse, data: Data, e: error.Type) -> error? {
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0
        
        // check status code before internal error check
        guard 200 ... 299 ~= statusCode else {
            if statusCode == StatusCode.unauthorized.rawValue {
                return NetworkError.status(.unauthorized) as? error
            } else if let sc = StatusCode(rawValue: statusCode) {
                return NetworkError.status(sc) as? error
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    private static func parseData<response: Codable, error: Error>(data: Data) -> Result<response, error> {
        guard let res = NetworkDataParser<response, error>(data: data)?.result() else {
            let networkError = NetworkError.status(.noContent)
            return .failure(networkError as! error)
        }
        
        return res
    }
}
