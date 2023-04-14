//
//  RoadmapSelectionView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

public struct RoadmapSelectionView: View {
    
    public init(backgroundColor: Color, foregroundColor: Color, icon: Image, header: String, details: LocalizedStringKey) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.icon = icon
        self.header = header
        self.details = details
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            icon
                .foregroundColor(foregroundColor)
                .font(.system(size: LayoutValues.buttonSize))
                .frame(width: LayoutValues.buttonSize, height: LayoutValues.buttonSize)
                .opacity(0.15)
                .padding(.bottom, -LayoutValues.minorPadding)
            
            VStack(spacing: LayoutValues.minorPadding / 4) {
                Text(header)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(details, bundle: .module)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.primary)
        }
        .defaultBackground(with: backgroundColor)
    }
    
    
    
    // MARK: - Variables
    
    let backgroundColor: Color
    let foregroundColor: Color
    
    let icon: Image
    let header: String
    let details: LocalizedStringKey
    
}
