//
//  Topic.swift
//  
//
//  Created by Kevin Waltz on 02.02.23.
//

import Foundation

public struct Topic: Codable {
    public let id: String
    public let title: String
    public let description: String
    public let type: String
    public let votes: Int
    public let didVote: Bool
}
