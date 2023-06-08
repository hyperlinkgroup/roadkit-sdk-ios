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
            HStack(spacing: Values.minorPadding) {
                Button(action: goBack, label: {
                    Image(systemName: "chevron.left")
                })
                
                Text(Strings.changelogHeader)
            }
            .font(.system(size: Values.navigationTextSize, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: Values.navigationBarHeight)
            .lineLimit(1)
            .padding(.leading, Values.middlePadding)
            #if os(iOS)
            .padding(.top, horizontalSizeClass == .compact ? 0 : Values.minorPadding)
            #else
            .padding(.top, Values.middlePadding)
            #endif
            
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
    }
    
    
    
    // MARK: - Variables
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    let primaryBackgroundColor: Color
    let secondaryBackgroundColor: Color
    let foregroundColor: Color
    
    let topicsViewModel: RoadKitTopicsViewModel
    
    
    
    // MARK: - Functions
    
    private func goBack() {
        presentationMode.wrappedValue.dismiss()
    }
}
