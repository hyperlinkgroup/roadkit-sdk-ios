//
//  ChangelogView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct ChangelogView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar(header: Strings.changelogHeader, showButtonToCloseView: true, foregroundColor: foregroundColor, action: dismissView)
            
            if !topicsViewModel.didFetchTopics {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    if !topicsViewModel.didFetchTopics || topicsViewModel.changelogViewModels.isEmpty {
                        ListPlaceholderView(backgroundColor: secondaryBackgroundColor, foregroundColor: foregroundColor)
                    } else {
                        VStack(spacing: LayoutValues.majorPadding) {
                            LazyVStack(spacing: LayoutValues.majorPadding) {
                                ForEach(topicsViewModel.changelogViewModels) { changelogViewModel in
                                    ChangelogItemView(changelogViewModel: changelogViewModel,
                                                      backgroundColor: secondaryBackgroundColor,
                                                      foregroundColor: foregroundColor)
                                }
                            }
                            
                            LogoView(backgroundColor: secondaryBackgroundColor)
                        }
                        .padding([.horizontal, .bottom], LayoutValues.minorPadding)
                    }
                }
            }
        }
        .background(primaryBackgroundColor)
        .hiddenNavigationBarStyle()
        #if os(macOS)
        .frame(minWidth: 600, maxWidth: 600, minHeight: 600, maxHeight: 600)
        #endif
    }
    
    
    
    // MARK: - Variables
    
    let primaryBackgroundColor: Color
    let secondaryBackgroundColor: Color
    let foregroundColor: Color
    
    let topicsViewModel: RoadKitTopicsViewModel
    
    @Binding var isPresented: Bool
    
    
    // MARK: - Functions
    
    private func dismissView() {
        isPresented = false
    }
}
