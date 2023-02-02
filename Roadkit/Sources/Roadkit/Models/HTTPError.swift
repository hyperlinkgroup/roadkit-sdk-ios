//
//  HTTPError.swift
//  
//
//  Created by Kevin Waltz on 02.02.23.
//

import Foundation

public enum HTTPError: LocalizedError {
    case statusCode(code: Int)
}
