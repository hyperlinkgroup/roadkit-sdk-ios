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

                Text(Strings.changelogHeader)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: dismissView, label: {
                    Image(systemName: "chevron.down")
                        .frame(width: Values.buttonSize, height: Values.buttonSize)
                        .background(Color.white.opacity(0.0000001))
                        .foregroundColor(foregroundColor)
                })
                .buttonStyle(.plain)
            }
            .font(.system(size: Values.navigationTextSize, weight: .semibold))
            .frame(height: Values.navigationBarHeight)
            .lineLimit(1)
            .padding(.horizontal, Values.middlePadding)
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
        #if os(macOS)
        .frame(minWidth: 600, maxWidth: 600, minHeight: 600, maxHeight: 600)
        #endif
    }
    
    
    
    // MARK: - Variables
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
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
