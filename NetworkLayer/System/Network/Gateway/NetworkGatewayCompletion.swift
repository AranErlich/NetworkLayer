//
//  NetworkGatewayCompletion.swift
//  NetworkLayer
//
//  Created by Aran Erlich on 21/07/2022.
//

import Foundation

extension NetworkGateway {
    
    // MARK: - Public Methods
    
    /// Performs network request.
    ///
    /// - Parameter:
    ///     - NetworkTarget
    /// - Return:
    ///     - task identifier
    ///     - completion with generic result
    /// - Present in the private dictionary for canceling request
    static func request<response: Codable> (target: NetworkTarget, completion: @escaping (Result<response, Error>) -> Void) {
        // Mock Task
        if target.mock, let url = target.urlRequest.url {
            do {
                let data = try Self.getMockData(url: url)
                Self.parseData(data: data, completion: completion)
            } catch {
                DispatchQueue.main.asyncMainIfNeeded {
                    completion(.failure(NetworkError.status(.badGateway)))
                }
            }
        }
        
        // get task for optional cancelling the request
        dataRequest(urlRequest: target.urlRequest, completion: completion)
    }
    
    // MARK: - helpers
    @discardableResult
    private static func dataRequest<response: Codable>(urlRequest: URLRequest, completion: @escaping (Result<response, Error>) -> Void) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, errorResponse) in
            DispatchQueue.main.async {
                if let validError = errorResponse {
                    completion(.failure(NetworkError.underlying(validError)))
                    return
                }
                
                guard let validResponse = response, let validData = data else {
                    completion(.failure(NetworkError.status(.noContent)))
                    return
                }
                
                if let returnedError = self.parseErrorIfNeeded(response: validResponse, data: validData) {
                    completion(.failure(returnedError))
                    return
                }
                
                // check for error regardless 200 ok
                Self.parseData(data: validData, completion: completion)
            }
        }
        task.resume()
        
        return task
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
    
    private static func parseData<response: Codable>(data: Data, completion: @escaping (Result<response, Error>) -> Void) {
        guard let res = NetworkDataParser<response>(data: data)?.result() else {
            let networkError = NetworkError.status(.noContent)
            completion(.failure(networkError))
            
            return
        }
        
        completion(res)
    }
    
}
