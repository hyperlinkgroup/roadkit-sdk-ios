//
//  AppInfo.swift
//  
//
//  Created by Kevin Waltz on 14.03.23.
//

import Foundation
import IOSystem

struct AppInfo: Codable {
    let locale, appVersion, appBuildNumber: String
    
    init() {
        self.locale = SystemManager.locale
        self.appVersion = SystemManager.appVersion
        self.appBuildNumber = SystemManager.appBuildNumber
    }
}
