//
//  ContentNetworkService.swift
//  NetworkLayer
//
//  Created by Aran Erlich on 16/06/2022.
//

import Foundation

protocol ContentNetworkServiceProtocol {
    func auth(model: ContentModel) async  // -> SomeResponse
}

class ContentNetworkService: NetworkTarget, ContentNetworkServiceProtocol {
    var body: Codable? = nil
    var target: String = ""
    var apiMethod: HTTPMethod {
        return .post
    }
    var baseURL: URL {
        let stringUrl = "http://example.com"
        return URL(string: stringUrl)!
    }
    
    func auth(model: ContentModel) async {
        body = model
        target = "some/auth/routing" // 🤷‍♂️
        _  = await execute(response: ContentModel.self, error: NetworkError.self)
        
//        return try? result.get()
    }
    
}
