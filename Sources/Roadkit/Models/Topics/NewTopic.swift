//
//  NewTopic.swift
//  
//
//  Created by Kevin Waltz on 03.02.23.
//

import Foundation

struct NewTopic: Codable {
    let type, title: String
    let description: String?
    let appInfo: AppInfo
    let deviceInfo: DeviceInfo
    
    
    init(type: String, title: String, description: String?) {
        self.type = type
        self.title = title
        self.description = description
        self.appInfo = AppInfo()
        self.deviceInfo = DeviceInfo()
    }
}
