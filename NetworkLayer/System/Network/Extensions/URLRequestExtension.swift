//
//  URLRequestExtension.swift
//  jet pay admin
//
//  Created by Aran Erlich on 04/10/2021.
//

import Foundation

extension URLRequest {
    
    mutating func encode(with parameters: Parameters, encoding: ParameterEncoding) {
        
        var urlEncoding = encoding
        
        do {
            let encoded = try urlEncoding.encode(self, with: parameters)
            self = encoded
        } catch {
            print(error.localizedDescription)
        }
    }
    
    mutating func encode(with string: String?, encoding: ParameterEncoding) {
        
        var urlEncoding = encoding
        
        do {
            let encoded = try urlEncoding.encode(self, with: string)
            self = encoded
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
