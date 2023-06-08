//
//  FeedbackView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI

struct FeedbackView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            HStack() {
                Text(Strings.feedbackHeader)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: dismissView, label: {
                    Image(systemName: "chevron.down")
                })
                .foregroundColor(foregroundColor)
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
            
            if feedbackSent {
                FeedbackPlaceholderView(image: Image(systemName: "hands.clap"), description: Strings.placeholderFeedbackSent)
            } else {
                VStack {
                    VStack(spacing: LayoutValues.minorPadding) {
                        VStack(spacing: LayoutValues.majorPadding) {
                            FeedbackTypeSelectionView(backgroundColor: secondaryBackgroundColor,
                                                      foregroundColor: foregroundColor,
                                                      type: $type)
                            
                            CustomTextEditor(placeholder: type.placeholder, text: $description)
                                .padding(.horizontal, LayoutValues.minorPadding)
                                .background(secondaryBackgroundColor)
                                .cornerRadius(LayoutValues.cornerRadius)
                        }
                            
                        PrimaryButton(foregroundColor: foregroundColor,
                                      title: Strings.send,
                                      isDisabled: disableButton,
                                      action: sendFeedback)
                    }
                    .padding(.bottom, LayoutValues.majorPadding + LayoutValues.minorPadding)
                }
                .adaptsToKeyboard()
                .edgesIgnoringSafeArea(.bottom)
                .padding(.horizontal, LayoutValues.minorPadding)
            }
        }
        .background(primaryBackgroundColor)
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
    
    @State var type = RoadKitTopicType.feedback
    @State var description = ""
    @State var feedbackSent = false
    
    @Binding var isPresented: Bool
    
    
    
    // MARK: - Computed Properties
    
    var disableButton: Bool {
        description.isEmpty
    }
    
    
    
    // MARK: - Functions
    
    private func sendFeedback() {
        RoadKitTopicsViewModel.shared.sendFeedback(type: type, description: description)
        
        withAnimation {
            feedbackSent.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            dismissView()
        }
    }
    
    private func dismissView() {
        isPresented = false
    }
    
}
