//
//  Routes.swift
//  
//
//  Created by Kevin Waltz on 03.02.23.
//

import Foundation

struct Routes {
    enum Endpoint {
        case topics, vote, submit
    }
    
    private let host = "https://europe-west3-roadkit-dev-swift.cloudfunctions.net/topics/"
    
    var endpoint: Endpoint
    
    var projectID = ""
    var topicID = ""
    var userID = ""
    
    
    var url: URL {
        var unsafeURL: URL?
        
        switch endpoint {
        case .topics:
            unsafeURL = URL(string: host + "\(projectID)/\(userID)")
        case .vote:
            unsafeURL = URL(string: host + "\(topicID)/\(userID)")
        case .submit:
            unsafeURL = URL(string: host)
        }
        
        guard let safeURL = unsafeURL else {
            fatalError("Invalid URL for endpoint \(endpoint)")
        }
        
        return safeURL
    }
}
