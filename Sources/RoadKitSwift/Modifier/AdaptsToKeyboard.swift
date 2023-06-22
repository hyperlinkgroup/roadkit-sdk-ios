//
//  AdaptsToKeyboard.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI
import Combine

struct AdaptsToKeyboard: ViewModifier {

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, currentHeight)
                .animation(.easeInOut, value: currentHeight)
                .onAppear {
                    listenToKeyboard(with: geometry)
                }
        }
    }
    
    
    
    // MARK: - Variables
    
    @State var cancellables = Set<AnyCancellable>()
    
    @State var keyboardIsShowing = false
    @State var currentHeight: CGFloat = 0
    
    
    
    // MARK: - Functions
    
    private func listenToKeyboard(with geometry: GeometryProxy) {
        #if os(iOS)
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { rect in
                rect.height - geometry.safeAreaInsets.bottom
            }
            .sink { height in
                self.keyboardIsShowing = true
                self.currentHeight = height
            }
            .store(in: &cancellables)

        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
            .map { _ in
                CGFloat.zero
            }
            .sink { height in
                self.keyboardIsShowing = false
                self.currentHeight = height
            }
            .store(in: &cancellables)
        #endif
    }
    
}

extension View {
    func adaptsToKeyboard() -> some View {
        modifier(AdaptsToKeyboard())
    }
}
