//
//  RoadmapItemView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct RoadmapItemView: View {
    
    var body: some View {
        VStack(spacing: LayoutValues.minorPadding / 2) {
            HStack(spacing: LayoutValues.minorPadding / 2) {
                VStack(spacing: LayoutValues.minorPadding / 4) {
                    Text(featureViewModel.object.title)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if !description.isEmpty {
                        Button(action: showInfo) {
                            Text(Strings.details, bundle: .module)
                                .font(.caption)
                                .foregroundColor(foregroundColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                if showVoting {
                    VotingButton(featureViewModel: featureViewModel, foregroundColor: foregroundColor)
                }
            }
            
            if shouldShowInfo, !description.isEmpty {
                Text(description)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .defaultBackground(with: backgroundColor)
    }
    
    
    
    // MARK: - Variables
    
    @State var shouldShowInfo = false
    
    let backgroundColor: Color
    let foregroundColor: Color
    
    let featureViewModel: RoadKitTopicViewModel
    let showVoting: Bool
    
    
    
    // MARK: - Computed Properties
    
    private var description: String {
        featureViewModel.object.description ?? ""
    }
    
    
    // MARK: - Functions
    
    private func showInfo() {
        withAnimation {
            shouldShowInfo.toggle()
        }
    }
    
}
