//
//  NetworkError.swift
//
//  Created by Aran Erlich on 04/10/2021.
//

import Foundation

enum NetworkError: Error {
    case underlying(Error)
    case status(StatusCode)
}

//public struct NetworkError: Codable, Error {
//    var success: Bool?
//    var errors: [NetworkErrorDetails]?
//    var statusCode: StatusCode?
//
//    var description: String? {
//        guard let desc = errors.flatMap({ $0.first?.errorDesc }) else { return nil }
//
//        if let sc = statusCode {
//            return desc + "\n" + "status code: \(sc)"
//        } else {
//            return desc
//        }
//    }
//}
//
//struct NetworkErrorDetails: Codable {
//    var errorCode: String?
//    var errorDesc: String?
//    var errorType: Int?
//    var validationErrors: [NetworkValidationError]?
//}
//
//struct NetworkValidationError: Codable {
//    var parameter: String?
//    var message: String?
//}
