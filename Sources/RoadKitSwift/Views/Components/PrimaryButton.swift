//
//  PrimaryButton.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct PrimaryButton: View {
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: LayoutValues.cornerRadius)
                    .foregroundColor(isDisabled ? .gray : foregroundColor)
                
                Text(title, bundle: .module)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(.plain)
        .frame(height: LayoutValues.buttonSize)
        .disabled(isDisabled)
    }
    
    
    
    // MARK: - Variables
    
    let foregroundColor: Color
    
    let title: LocalizedStringKey
    var isDisabled = false
    var action: () -> Void
    
}
