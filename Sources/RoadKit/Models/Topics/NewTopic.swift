//
//  NewTopic.swift
//  
//
//  Created by Kevin Waltz on 03.02.23.
//

import Foundation

struct NewTopic: Codable {
    let type, notes: String
    let appInfo: AppInfo
    let deviceInfo: DeviceInfo
    
    
    init(type: String, description: String) {
        self.type = type
        self.notes = description
        self.appInfo = AppInfo()
        self.deviceInfo = DeviceInfo()
    }
}
