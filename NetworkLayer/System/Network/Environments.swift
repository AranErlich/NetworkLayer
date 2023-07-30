//
//  Environments.swift
//
//  Created by Aran Erlich on 04/10/2021.
//

import Foundation

enum Environments: CustomStringConvertible {
    
    static let current: Environments = .staging
    
    case develop
    case staging
    case production
    
    var rawValue: String {
        switch Self.current {
        case .develop:
            return ""
        case .staging:
            return ""
        case .production:
            return ""
        }
    }
    
    var description: String {
        return rawValue
    }
    
}
