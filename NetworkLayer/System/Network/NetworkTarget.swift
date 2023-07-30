//
//  NetworkTarget.swift
//
//  Created by Aran Erlich on 04/10/2021.
//

import Foundation

public protocol NetworkTarget {
    var headerParams: [String: String]? { get }
    var queryParams: [String: String]? { get }
    var body: Codable? { get }
    var baseURL: URL { get }
    var apiMethod: HTTPMethod { get }
    var target: String { get }
    var urlRequest: URLRequest { get }
    var timeoutInterval: TimeInterval { get }
    var mock: Bool { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
}

public extension NetworkTarget {
    
    var headerParams: [String: String]? {
        return nil
    }

    var queryParams: [String: String]? {
        return nil
    }
    
    var apiMethod: HTTPMethod {
        return .get
    }
    
//    var baseURL: URL {
//        let env = Environments.current.rawValue
//        let base = URL(string: env)
//        
//        return base
//    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
    
    var timeoutInterval: TimeInterval {
        return 30
    }
    
    var body: Codable? {
        return nil
    }
    
    var mock: Bool {
        return false
    }
    
    var urlRequest: URLRequest {
        if mock {
            let path = Bundle.main.path(forResource: target, ofType: "json") ?? String()
            let url = URL(fileURLWithPath: path)
            
            return URLRequest(url: url)
        }
        
        var url = baseURL
        url.appendPathComponent(target)
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = apiMethod.rawValue
        
        addDefaultHeaders(&request)
        if let headerParams = headerParams {
            headerParams.forEach { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let queryParams = queryParams {
            var params: [URLQueryItem] = []
            queryParams.forEach { (key, value) in
                let qItem = URLQueryItem(name: key, value: value)
                params.append(qItem)
            }
            
            request.url?.append(queryItems: params)
        }

        switch apiMethod {
        case .post, .put, .delete, .patch, .options:
            if let httpBody = body?.toData() {
                request.httpBody = httpBody
            }
        default:
            break
        }
        
        return request
    }
    
    private func addDefaultHeaders(_ request: inout URLRequest) {
        
    }
    
}

// MARK: - perform request extension
extension NetworkTarget {
    
    func execute<response: Codable>(_ completion: @escaping (Result<response, Error>) -> Void) {
        return NetworkGateway.execute(target: self, completion: completion)
    }
    
    func execute<response: Codable>(response: response.Type) async -> Result<response, Error> {
        return await NetworkGateway.execute(target: self)
    }
    
}
