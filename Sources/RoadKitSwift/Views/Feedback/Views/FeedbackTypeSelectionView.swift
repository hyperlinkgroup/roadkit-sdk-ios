//
//  FeedbackTypeSelectionView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct FeedbackTypeSelectionView: View {
    
    var body: some View {
        VStack(spacing: LayoutValues.middlePadding / 2) {
            HStack(spacing: LayoutValues.minorPadding) {
                ForEach(RoadKitTopicType.allCases, id: \.rawValue) { type in
                    Button {
                        self.type = type
                    } label: {
                        type.icon
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(width: LayoutValues.buttonSize, height: LayoutValues.buttonSize)
                            .background(backgroundColor)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .strokeBorder(self.type == type ? foregroundColor : .clear, lineWidth: 2)
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            
            Text(type.title, bundle: .module)
                .font(.headline)
        }
    }
    
    
    
    // MARK: - Variables
    
    let backgroundColor: Color
    let foregroundColor: Color
    
    @Binding var type: RoadKitTopicType
    
}
