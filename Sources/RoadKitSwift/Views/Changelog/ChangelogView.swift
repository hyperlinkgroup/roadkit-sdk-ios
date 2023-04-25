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
            
            ZStack(alignment: .bottom) {
                LogoView()
                
                if !topicsViewModel.didFetchTopics {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        if !topicsViewModel.didFetchTopics || topicsViewModel.changelogViewModels.isEmpty {
                            ListPlaceholderView(backgroundColor: secondaryBackgroundColor, foregroundColor: foregroundColor)
                        } else {
                            LazyVStack(spacing: LayoutValues.majorPadding) {
                                ForEach(topicsViewModel.changelogViewModels) { changelogViewModel in
                                    ChangelogItemView(changelogViewModel: changelogViewModel,
                                                      backgroundColor: secondaryBackgroundColor,
                                                      foregroundColor: foregroundColor)
                                }
                            }
                            .padding(.bottom, 120)
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom], LayoutValues.minorPadding)
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
