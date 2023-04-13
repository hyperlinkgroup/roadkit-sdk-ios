//
//  RoadKitObjectModel.swift
//  
//
//  Created by Kevin Waltz on 13.02.23.
//

import Foundation

public protocol RoadKitObjectModel: Identifiable, Codable, Hashable {
    var id: String? { get }
}

extension RoadKitObjectModel {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
}
