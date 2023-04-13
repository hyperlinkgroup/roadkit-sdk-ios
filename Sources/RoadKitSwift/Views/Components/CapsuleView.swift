//
//  CapsuleView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct CapsuleView: View {
    
    var body: some View {
        Text(title)
            .font(.footnote.weight(.semibold))
            .foregroundColor(.white)
            .if(fill) { text in
                text.frame(maxWidth: .infinity)
            }
            .padding(.horizontal, LayoutValues.middlePadding / 2)
            .padding(.vertical, LayoutValues.minorPadding / 4)
            .background(background)
            .clipShape(Capsule())
    }
    
    
    
    // MARK: - Variables
    
    let title: String
    let background: Color
    var fill = false
    
}
