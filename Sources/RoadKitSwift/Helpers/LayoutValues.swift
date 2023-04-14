//
//  LayoutValues.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import Foundation

struct LayoutValues {
    
    #if os(macOS)
    static let minorPadding: CGFloat = 12
    static let middlePadding: CGFloat = 18
    static let majorPadding: CGFloat = 30
    
    static let cornerRadius: CGFloat = 10
    
    static let iconSizeSmall: CGFloat = 4
    static let iconSize: CGFloat = 12
    static let iconSizeLarge: CGFloat = 16
    
    static let itemSize: CGFloat = 20
    static let itemSizeLarge: CGFloat = 24
    
    static let bottomButtonSize: CGFloat = 40
    static let buttonSize: CGFloat = 30
    #else
    static let minorPadding: CGFloat = 16
    static let middlePadding: CGFloat = 24
    static let majorPadding: CGFloat = 32
    
    static let cornerRadius: CGFloat = 12
    static let cornerRadiusInside: CGFloat = 6
    
    static let iconSizeSmall: CGFloat = 8
    static let iconSize: CGFloat = 16
    static let iconSizeLarge: CGFloat = 18
    
    static let itemSize: CGFloat = 30
    static let itemSizeLarge: CGFloat = 36
    
    static let bottomButtonSize: CGFloat = 60
    static let buttonSize: CGFloat = 44
    #endif
}
