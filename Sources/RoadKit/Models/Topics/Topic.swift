//
//  Topic.swift
//  
//
//  Created by Kevin Waltz on 02.02.23.
//

import Foundation

public struct Topic: RoadKitObjectModel {
    public var id: String?
    public var topicId: String { id ?? ""}
    
    public let title: String
    public let description: String?
    public let type: String
    public let votes: Int
    public let userDidVote: Bool
    
    public let priority: String?
    public let status: String?
    public let version: String?
}
