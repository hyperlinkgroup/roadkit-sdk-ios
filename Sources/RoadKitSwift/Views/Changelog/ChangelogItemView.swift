//
//  ChangelogItemView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI
import OrderedCollections

struct ChangelogItemView: View {
    
    var body: some View {
        VStack(spacing: LayoutValues.minorPadding / 2) {
            HStack {
                CapsuleView(title: changelogViewModel.version,
                            background: foregroundColor)
                
                Spacer()
            }
            
            LazyVStack(spacing: LayoutValues.middlePadding) {
                ForEach(changelogViewModel.changelogGroups.elements, id: \.key) { changelogGroup in
                    LazyVStack(spacing: LayoutValues.minorPadding / 2) {
                        VStack(spacing: LayoutValues.minorPadding / 4) {
                            ChangelogHeaderView(title: changelogGroup.key.title,
                                                icon: changelogGroup.key.icon,
                                                foregroundColor: foregroundColor)
                            
                            Divider()
                        }
                        
                        ForEach(changelogGroup.value) { topicViewModel in
                            HStack(spacing: LayoutValues.minorPadding / 2) {
                                Text("•")
                                
                                Text(topicViewModel.object.title)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .font(.callout)
                        }
                    }
                }
            }
            .padding(.horizontal, LayoutValues.minorPadding / 2)
            .defaultBackground(with: backgroundColor)
        }
        .padding(.horizontal, Values.minorPadding)
    }
    
    
    
    // MARK: - Variables
    
    let changelogViewModel: RoadKitChangelogViewModel
    let backgroundColor: Color
    let foregroundColor: Color
    
}
