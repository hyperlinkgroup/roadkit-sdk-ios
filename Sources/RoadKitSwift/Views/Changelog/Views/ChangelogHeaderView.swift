//
//  ChangelogHeaderView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct ChangelogHeaderView: View {
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title, bundle: .module)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            icon
                .foregroundColor(foregroundColor)
                .frame(width: LayoutValues.iconSize, height: LayoutValues.iconSize)
        }
        .font(.headline)
    }
    
    
    
    // MARK: - Variables
    
    let title: LocalizedStringKey
    let icon: Image
    let foregroundColor: Color
    
}
