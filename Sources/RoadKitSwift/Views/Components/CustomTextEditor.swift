//
//  CustomTextEditor.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct CustomTextEditor: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(placeholder, bundle: .module)
                .foregroundColor(.gray.opacity(0.4))
                .font(.body)
                .padding(.horizontal, LayoutValues.minorPadding / 4)
                .opacity(text.isEmpty ? 1 : 0)
                #if os(iOS)
                .padding(.top, LayoutValues.minorPadding / 2)
                #endif
            
            TextEditor(text: $text)
                .font(.body)
                .opacity(text.isEmpty ? 1 : 1)
                .background(.clear)
                .onChange(of: text) { text = $0 }
                #if os(iOS)
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button(action: hideKeyboard) { Image(systemName: "keyboard.chevron.compact.down") }
                    }
                }
                #endif
            
            Text(text).opacity(0).padding(LayoutValues.middlePadding / 4)
                .font(.body)
        }
        .padding(.top, 2)
        .padding(.horizontal, -LayoutValues.minorPadding / 4)
    }
    
    
    
    // MARK: - Variables
    
    let placeholder: LocalizedStringKey
    
    @Binding var text: String
    
}
