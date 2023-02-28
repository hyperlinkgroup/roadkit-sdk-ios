//
//  RoadkitObjectViewModel.swift
//  
//
//  Created by Kevin Waltz on 13.02.23.
//

import Foundation

open class RoadkitObjectViewModel<T: RoadkitObjectModel>: ObservableObject, Equatable {
    
    @Published public var object: T
    
    
    public init(object: T) {
        self.object = object
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(object)
    }
    
    public static func == (lhs: RoadkitObjectViewModel, rhs: RoadkitObjectViewModel) -> Bool {
        lhs.object == rhs.object
    }
}
