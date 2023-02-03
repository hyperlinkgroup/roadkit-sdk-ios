//
//  File.swift
//  
//
//  Created by Kevin Waltz on 03.02.23.
//

import Foundation

struct NewTopic: Codable {
    let title: String
    let description: String
    let projectId: String
    let type: String
    let users: [String]
    
    
    init(title: String, description: String?, type: TopicType, projectId: String, userId: String) {
        self.title = title
        self.description = description ?? ""
        self.projectId = projectId
        self.type = type.rawValue
        self.users = [userId]
    }
}
