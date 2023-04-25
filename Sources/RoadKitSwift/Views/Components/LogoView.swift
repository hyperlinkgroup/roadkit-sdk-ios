//
//  LogoView.swift
//  
//
//  Created by Kevin Waltz on 25.04.23.
//

import SwiftUI

struct LogoView: View {
    
    var body: some View {
        HStack(spacing: LayoutValues.minorPadding) {
            VStack(spacing: LayoutValues.minorPadding / 6) {
                Text("Provided by")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("RoadKit")
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
        .background(.thinMaterial)
        .cornerRadius(LayoutValues.cornerRadius)
        .frame(maxWidth: 150)
    }
    
}
