//
//  RoadKitObjectViewModel.swift
//  
//
//  Created by Kevin Waltz on 13.02.23.
//

import Foundation

open class RoadKitObjectViewModel<T: RoadKitObjectModel>: ObservableObject, Identifiable, Equatable {
    
    @Published public var object: T
    
    
    public init(object: T) {
        self.object = object
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(object)
    }
    
    public static func == (lhs: RoadKitObjectViewModel, rhs: RoadKitObjectViewModel) -> Bool {
        lhs.object == rhs.object
    }
}
