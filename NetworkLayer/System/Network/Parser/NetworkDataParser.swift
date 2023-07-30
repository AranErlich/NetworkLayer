//
//  NetworkDataHandler.swift
//
//  Created by Aran Erlich on 06/10/2021.
//

import Foundation

class NetworkDataParser<T:Codable, error: Error> {
    
    private var data: Data
    private var object: T?
    private var err: error?
    
    init?(data: Data) {
        guard let response = try? NetworkResponse<T>.parse(data: data) else { return nil }
        self.data = data
        
        if let validData = response.data {
            object = validData
        } else {
            let networkError: NetworkError = .status(.noContent)
            err = (networkError as! error)
        }
    }
    
    func result() -> Result<T,error> {
        if let error = err {
            return .failure(error)
        } else if let object = self.object {
            return .success(object)
        } else {
            return .failure(err!)
        }
    }
}
