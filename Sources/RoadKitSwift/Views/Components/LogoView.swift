//
//  LogoView.swift
//  
//
//  Created by Kevin Waltz on 25.04.23.
//

import SwiftUI

struct LogoView: View {
    
    var body: some View {
        Link(destination: URL(string: "https://ssq.es/rok")!) {
            HStack(spacing: LayoutValues.minorPadding) {
                VStack(spacing: LayoutValues.minorPadding / 6) {
                    Text(Strings.providedBy)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(Strings.roadkit)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Image("roadkit_logo", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
            }
            .background(.white.opacity(0.000001))
            .foregroundColor(.primary)
            .padding(LayoutValues.minorPadding)
            .background(backgroundColor)
            .cornerRadius(LayoutValues.cornerRadius)
            .frame(maxWidth: 150)
        }
        .buttonStyle(.plain)
    }
    
    
    
    // MARK: - Variables
    
    let backgroundColor: Color
    
}
