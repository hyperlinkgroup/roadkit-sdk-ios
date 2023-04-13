//
//  VotingButton.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct VotingButton: View {
    
    var body: some View {
        Button(action: vote) {
            HStack(spacing: LayoutValues.minorPadding / 2) {
                featureViewModel.object.userDidVote ? Image(systemName: "arrowtriangle.down.fill") : Image(systemName: "arrowtriangle.up.fill")
                
                Text(String(describing: featureViewModel.object.votes))
            }
            .font(.subheadline)
            .background(.white.opacity(0.000001))
            .padding(.vertical, LayoutValues.minorPadding / 4)
            .padding(.horizontal, LayoutValues.minorPadding)
            .foregroundColor(featureViewModel.object.userDidVote ? .white : foregroundColor)
            .background(featureViewModel.object.userDidVote ? foregroundColor : .clear)
            .clipShape(Capsule())
            .if(!featureViewModel.object.userDidVote) { button in
                button.overlay { Capsule().strokeBorder(foregroundColor, lineWidth: 2) }
            }
        }
        .buttonStyle(.plain)
    }
    
    
    
    // MARK: - Variables
    
    let featureViewModel: RoadKitTopicViewModel
    let foregroundColor: Color
    
    
    
    // MARK: - Functions
    
    private func vote() {
        featureViewModel.voteFeature()
    }
    
}
