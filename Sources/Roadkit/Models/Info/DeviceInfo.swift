//
//  DeviceInfo.swift
//  
//
//  Created by Kevin Waltz on 14.03.23.
//

import Foundation
import IOSystem

struct DeviceInfo: Codable {
    let platform, systemVersion, device, deviceName, deviceType: String
    
    
    init() {
        self.platform = SystemManager.platform.rawValue
        self.systemVersion = SystemManager.systemVersion
        self.device = SystemManager.device.name
        self.deviceName = SystemManager.deviceName.name
        self.deviceType = SystemManager.deviceType
    }
}
