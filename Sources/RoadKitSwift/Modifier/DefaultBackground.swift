//
//  DefaultBackground.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct DefaultBackground: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(LayoutValues.middlePadding / 2)
            .background(backgroundColor)
            .cornerRadius(LayoutValues.cornerRadius)
    }
    
    
    
    // MARK: - Variables
    
    let backgroundColor: Color
    
}

extension View {
    func defaultBackground(with backgroundColor: Color) -> some View {
        modifier(DefaultBackground(backgroundColor: backgroundColor))
    }
}
