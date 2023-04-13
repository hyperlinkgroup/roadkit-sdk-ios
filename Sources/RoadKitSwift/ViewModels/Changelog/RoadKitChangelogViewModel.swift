//
//  RoadKitChangelogViewModel.swift
//  RoadKit
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI
import Collections

class RoadKitChangelogViewModel: ObservableObject, Identifiable {
    
    init(version: String, topicViewModels: [RoadKitTopicViewModel]) {
        self.version = version
        
        var changelogGroups = OrderedDictionary(grouping: topicViewModels) { RoadKitTopicType(rawValue: $0.object.type) ?? .feature }
        changelogGroups.sort { $0.key.order < $1.key.order }
        
        self.changelogGroups = changelogGroups
    }
    
    
    // MARK: - Variables
    
    var version: String
    var changelogGroups: OrderedDictionary<RoadKitTopicType, [RoadKitTopicViewModel]> = [:]
    
}
