//
//  RoadKitTopicType.swift
//  
//
//  Created by Kevin Waltz on 03.02.23.
//

import SwiftUI

public enum RoadKitTopicType: String, CaseIterable, Identifiable {
    case feedback, feature, improvement, bug
    
    
    public var id: String { rawValue }
    
    public var order: Int {
        switch self {
        case .feedback: return 0
        case .feature: return 1
        case .improvement: return 2
        case .bug: return 3
        }
    }
    
    public var title: LocalizedStringKey {
        switch self {
        case .feedback: return Strings.feedback
        case .feature: return Strings.features
        case .improvement: return Strings.improvements
        case .bug: return Strings.bugs
        }
    }
    
    public var icon: Image {
        switch self {
        case .feedback: return Image(systemName: "doc.append.fill")
        case .feature: return Image(systemName: "star")
        case .improvement: return Image(systemName: "wand.and.stars")
        case .bug: return Image(systemName: "ladybug")
        }
    }
    
    
    public var placeholder: LocalizedStringKey {
        switch self {
        case .feedback: return Strings.placeholderFeedback
        case .feature: return Strings.placeholderFeatures
        case .improvement: return Strings.placeholderImprovements
        case .bug: return Strings.placeholderBugs
        }
    }
}
