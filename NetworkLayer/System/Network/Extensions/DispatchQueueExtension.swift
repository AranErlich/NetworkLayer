//
//  DispatchQueueExtension.swift
//
//  Created by Aran Erlich on 04/10/2021.
//

import Foundation

extension DispatchQueue {
    
    public func asyncMainIfNeeded(_ block: @escaping () -> Void) {
        if !Thread.isMainThread {
            async {
                block()
            }
        } else {
            block()
        }
    }
    
}
