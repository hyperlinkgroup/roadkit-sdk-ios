//
//  ChangelogView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI
import IONavigation

struct ChangelogView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Navigationbar(title: "Changelog")
                .backItem()
            
            ScrollView {
                if topicsViewModel.changelogViewModels.isEmpty {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    LazyVStack(spacing: LayoutValues.majorPadding) {
                        ForEach(topicsViewModel.changelogViewModels) { changelogViewModel in
                            ChangelogItemView(changelogViewModel: changelogViewModel,
                                              backgroundColor: secondaryBackgroundColor,
                                              foregroundColor: foregroundColor)
                        }
                    }
                    .padding(.horizontal, LayoutValues.minorPadding)
                    .padding(.bottom, LayoutValues.minorPadding)
                }
            }
        }
        .background(primaryBackgroundColor)
        .hiddenNavigationBarStyle()
    }
    
    
    
    // MARK: - Variables
    
    let primaryBackgroundColor: Color
    let secondaryBackgroundColor: Color
    let foregroundColor: Color
    
    let topicsViewModel: RoadKitTopicsViewModel
    
}
