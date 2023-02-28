//
//  HTTPMethod.swift
//  
//
//  Created by Kevin Waltz on 03.02.23.
//

import Foundation

enum HTTPMethod: String {
    case get, post, put
    
    
    var httpMethod: String {
        rawValue.uppercased()
    }
}
