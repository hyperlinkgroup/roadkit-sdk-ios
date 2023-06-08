//
//  File.swift
//  
//
//  Created by Heiko Rothermel on 07.06.23.
//

import SwiftUI

struct Values {
    
    #if os(macOS)
    static let minorPadding: CGFloat = 12
    static let middlePadding: CGFloat = 16
    static let majorPadding: CGFloat = 24
    
    static let cornerRadius: CGFloat = 8
    
    static let navigationBarHeight: CGFloat = 44
    static let navigationTextSize: CGFloat = 18
    
    #else
    static let minorPadding: CGFloat = 16
    static let middlePadding: CGFloat = 24
    static let majorPadding: CGFloat = 36

    static let cornerRadius: CGFloat = 8

    static let navigationBarHeight: CGFloat = 60
    static let navigationTextSize: CGFloat = 24
    #endif
    
}
