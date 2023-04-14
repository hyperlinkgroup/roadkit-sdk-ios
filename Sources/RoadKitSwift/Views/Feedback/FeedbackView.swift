//
//  FeedbackView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI
import IONavigation

struct FeedbackView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Navigationbar(title: "Feedback")
                .navigationItem(image: Image(systemName: "chevron.down"), color: foregroundColor, action: dismissView)
            
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
        .macWindowSize(minWidth: 600, maxWidth: 600, minHeight: 600, maxHeight: 600)
    }
    
    
    
    // MARK: - Variables
    
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
