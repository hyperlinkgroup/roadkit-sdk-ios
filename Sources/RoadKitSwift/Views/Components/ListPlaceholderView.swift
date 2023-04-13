//
//  ListPlaceholderView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct ListPlaceholderView: View {
    
    var body: some View {
        HStack(spacing: LayoutValues.middlePadding) {
            Text(Strings.noContent, bundle: .module)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "archivebox")
                .font(.system(size: 36))
                .foregroundColor(foregroundColor)
        }
        .defaultBackground(with: backgroundColor)
    }
    
    
    
    // MARK: - Variables
    
    let backgroundColor: Color
    let foregroundColor: Color
    
}
