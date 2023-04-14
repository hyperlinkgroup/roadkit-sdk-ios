//
//  View.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}
