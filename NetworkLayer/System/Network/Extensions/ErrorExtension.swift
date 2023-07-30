//
//  ErrorExtension.swift
//  NetworkLayer
//
//  Created by Aran Erlich on 21/07/2022.
//

import Foundation

extension Error {
    var code: Int {
        return (self as NSError).code
    }
}
