//
//  NavigationBar.swift
//  
//
//  Created by Heiko Rothermel on 09.06.23.
//

import SwiftUI

struct NavigationBar: View {
    
    var body: some View {
        HStack(spacing: Values.minorPadding) {
            Text(header)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if showButtonToCloseView {
                Button(action: action, label: {
                    Image(systemName: "chevron.down")
                        .frame(width: Values.buttonSize, height: Values.buttonSize)
                        .foregroundColor(foregroundColor)
                        .contentShape(Rectangle())
                })
                .buttonStyle(.plain)
            }
        }
        .font(.system(size: Values.navigationTextSize, weight: .semibold))
        .frame(height: Values.navigationBarHeight)
        .lineLimit(1)
        .padding(.horizontal, Values.middlePadding)
        #if os(iOS)
        .padding(.top, horizontalSizeClass == .compact ? 0 : Values.minorPadding)
        #else
        .padding(.top, Values.middlePadding)
        #endif
    }
    
    
    
    // MARK: Variables
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    var header: String
    var showButtonToCloseView: Bool
    var foregroundColor: Color
    var action: () -> Void
    
}
