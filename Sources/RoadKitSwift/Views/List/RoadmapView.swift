//
//  RoadmapView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI
import IONavigation

public struct RoadmapView: View {
    
    public init(isPresented: Binding<Bool>, primaryBackgroundColor: Color, secondaryBackgroundColor: Color, foregroundColor: Color) {
        self._isPresented = isPresented
        self.primaryBackgroundColor = primaryBackgroundColor
        self.secondaryBackgroundColor = secondaryBackgroundColor
        self.foregroundColor = foregroundColor
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: LayoutValues.minorPadding) {
                Navigationbar(title: Strings.roadmapHeader)
                    .if(isPresented) { navigationBar in
                        navigationBar.navigationItem(image: Image(systemName: "chevron.down"), color: foregroundColor, action: dismissView)
                    }
                
                VStack(spacing: LayoutValues.middlePadding * 2) {
                    if !topicsViewModel.didFetchTopics {
                        actionButtonView
                        
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: LayoutValues.majorPadding) {
                                actionButtonView
                                
                                VStack(spacing: LayoutValues.minorPadding / 2) {
                                    Text(Strings.whatsNext, bundle: .module)
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Picker("", selection: $roadmapSelection) {
                                        ForEach(RoadmapSelection.allCases) { selection in
                                            Text(selection.title, bundle: .module)
                                                .tag(selection)
                                        }
                                    }
                                    .pickerStyle(.segmented)
                                    .labelsHidden()
                                    .padding(.bottom, LayoutValues.minorPadding)
                                    
                                    if topicViewModels.isEmpty {
                                        ListPlaceholderView(backgroundColor: secondaryBackgroundColor, foregroundColor: foregroundColor)
                                    } else {
                                        LazyVStack(spacing: LayoutValues.minorPadding) {
                                            ForEach(topicViewModels, id: \.id) { featureViewModel in
                                                VStack(spacing: LayoutValues.minorPadding / 2) {
                                                    RoadmapItemView(backgroundColor: secondaryBackgroundColor,
                                                                    foregroundColor: foregroundColor,
                                                                    featureViewModel: featureViewModel,
                                                                    showVoting: true)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                LogoView(backgroundColor: secondaryBackgroundColor)
                            }
                            .padding(.bottom, LayoutValues.minorPadding)
                        }
                    }
                }
                .padding(.horizontal, LayoutValues.minorPadding)
            }
            .buttonStyle(.plain)
            .background(primaryBackgroundColor)
            .sheet(isPresented: $shouldShowFeedback) {
                FeedbackView(primaryBackgroundColor: primaryBackgroundColor,
                             secondaryBackgroundColor: secondaryBackgroundColor,
                             foregroundColor: foregroundColor,
                             isPresented: $shouldShowFeedback)
            }
        }
    }
    
    var actionButtonView: some View {
        HStack(spacing: LayoutValues.minorPadding) {
            Button(action: showFeedbackSheet) {
                RoadmapSelectionView(backgroundColor: secondaryBackgroundColor,
                                     foregroundColor: foregroundColor,
                                     icon: Image(systemName: "lightbulb.fill"),
                                     header: Strings.feedbackHeader,
                                     details: Strings.feedbackDescription)
            }
            
            NavigationLink {
                ChangelogView(primaryBackgroundColor: primaryBackgroundColor,
                              secondaryBackgroundColor: secondaryBackgroundColor,
                              foregroundColor: foregroundColor,
                              topicsViewModel: topicsViewModel)
            } label: {
                RoadmapSelectionView(backgroundColor: secondaryBackgroundColor,
                                     foregroundColor: foregroundColor,
                                     icon: Image(systemName: "map.fill"),
                                     header: Strings.changelogHeader,
                                     details: Strings.changelogDescription)
            }
        }
    }
    
    
    // MARK: - Variables
    
    @StateObject var topicsViewModel = RoadKitTopicsViewModel.shared
    
    @State var shouldShowFeedback = false
    @State var roadmapSelection: RoadmapSelection = .features
    
    @Binding var isPresented: Bool
    
    let primaryBackgroundColor: Color
    let secondaryBackgroundColor: Color
    let foregroundColor: Color
    
    
    
    // MARK: Cumputed Properties
    
    private var topicViewModels: [RoadKitTopicViewModel] {
        switch roadmapSelection {
        case .features: return topicsViewModel.featureViewModels
        case .bugs: return topicsViewModel.bugViewModels
        }
    }
    
    
    
    // MARK: - Functions
    
    private func showFeedbackSheet() {
        shouldShowFeedback = true
    }
    
    private func dismissView() {
        isPresented = false
    }
    
}
