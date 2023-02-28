//
//  NetworkResponse.swift
//  
//
//  Created by Kevin Waltz on 03.02.23.
//

import Foundation

public struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var result: Wrapped
}
