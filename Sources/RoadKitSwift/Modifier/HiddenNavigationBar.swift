//
//  HiddenNavigationBar.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            #if os(iOS)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            #endif
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier(HiddenNavigationBar())
    }
}
