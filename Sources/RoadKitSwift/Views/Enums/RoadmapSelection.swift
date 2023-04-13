//
//  RoadmapSelection.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

enum RoadmapSelection: String, CaseIterable, Identifiable {
    case features, bugs
    
    
    var id: String { rawValue }
    
    var title: LocalizedStringKey {
        switch self {
        case .features: return Strings.features
        case .bugs: return Strings.bugs
        }
    }
}
