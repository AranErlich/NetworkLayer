//
//  NetworkDataHandler.swift
//
//  Created by Aran Erlich on 06/10/2021.
//

import Foundation

class NetworkDataParser<T:Codable> {
    
    private var data: Data
    private var object: T?
    private var err: NetworkError?
    
    init?(data: Data) {
        if let response = try? T.parse(data: data) {
            object = response
        } else {
            let networkError: NetworkError = .status(.noContent)
            err = networkError
        }
        
        self.data = data
    }
    
    func result() -> Result<T, Error> {
        if let error = err {
            return .failure(error)
        } else if let object = self.object {
            return .success(object)
        } else {
            return .failure(err!)
        }
    }
}
