//
//  RoadkitObjectModel.swift
//  
//
//  Created by Kevin Waltz on 13.02.23.
//

import Foundation

public protocol RoadkitObjectModel: Identifiable, Codable, Hashable {
    var id: String? { get }
}

extension RoadkitObjectModel {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
}
