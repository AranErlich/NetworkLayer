//
//  StatusCode.swift
//
//  Created by Aran Erlich on 04/10/2021.
//

import Foundation

enum StatusCode: Int, Codable {
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204
    
    case redirect = 300
    case redirectPermanently = 301
    case redirectTemporarily = 302
    
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    
    case internalServerError = 500
    case badGateway = 502
    case gatewayUnavailable = 503
    case gatewayTimeout = 504
}
