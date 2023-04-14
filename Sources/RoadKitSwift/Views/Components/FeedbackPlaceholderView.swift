//
//  FeedbackPlaceholderView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct FeedbackPlaceholderView: View {
    
    var body: some View {
        VStack(spacing: LayoutValues.middlePadding * 2) {
            VStack(spacing: LayoutValues.middlePadding) {
                image
                    .font(.system(size: 100))
                
                Text(description, bundle: .module)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    
    
    // MARK: - Variables
    
    let image: Image
    let description: LocalizedStringKey
    
}
