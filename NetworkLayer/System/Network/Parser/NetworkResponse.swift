//
//  NetworkResponse.swift
//  NetworkLayer
//
//  Created by Aran Erlich on 21/07/2022.
//

import Foundation

struct NetworkResponse<T:Codable>: Codable {
    var data: T?
    // add any other properties for your server response
    
//    var success: Bool?
//    var errors: [Error]?
}
