//
//  RoadmapView.swift
//  
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI
//import IONavigation

public struct RoadmapView: View {
    
    public init(isPresented: Binding<Bool>, primaryBackgroundColor: Color, secondaryBackgroundColor: Color, foregroundColor: Color) {
        self._isPresented = isPresented
        self.primaryBackgroundColor = primaryBackgroundColor
        self.secondaryBackgroundColor = secondaryBackgroundColor
        self.foregroundColor = foregroundColor
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack() {
                Text(Strings.roadmapHeader)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                #if os(iOS)
                Button(action: dismissView, label: {
                    Image(systemName: "chevron.down")
                        .frame(width: Values.buttonSize, height: Values.buttonSize)
                        .background(Color.white.opacity(0.0000001))
                        .foregroundColor(foregroundColor)
                })
                #endif
            }
            .font(.system(size: Values.navigationTextSize, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: Values.navigationBarHeight)
            .lineLimit(1)
            .padding(.horizontal, Values.middlePadding)
            #if os(iOS)
            .padding(.top, horizontalSizeClass == .compact ? 0 : Values.minorPadding)
            #else
            .padding(.top, Values.middlePadding)
            #endif
            
            VStack(spacing: LayoutValues.middlePadding * 2) {
                HStack(spacing: LayoutValues.minorPadding) {
                    Button(action: showFeedbackSheet) {
                        RoadmapSelectionView(backgroundColor: secondaryBackgroundColor,
                                             foregroundColor: foregroundColor,
                                             icon: Image(systemName: "lightbulb.fill"),
                                             header: Strings.feedbackHeader,
                                             details: Strings.feedbackDescription)
                    }
                    
                    Button(action: showChangelogSheet) {
                        RoadmapSelectionView(backgroundColor: secondaryBackgroundColor,
                                             foregroundColor: foregroundColor,
                                             icon: Image(systemName: "map.fill"),
                                             header: Strings.changelogHeader,
                                             details: Strings.changelogDescription)
                    }
                }
                .padding(.horizontal, LayoutValues.minorPadding)
                
                if !topicsViewModel.didFetchTopics {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: LayoutValues.majorPadding) {
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
                                
                                if topicsViewModel.didFetchTopics && topicViewModels.isEmpty {
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
                        .padding([.horizontal, .bottom], LayoutValues.minorPadding)
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .background(primaryBackgroundColor)
        .sheet(isPresented: $shouldShowFeedback) {
            FeedbackView(primaryBackgroundColor: primaryBackgroundColor,
                         secondaryBackgroundColor: secondaryBackgroundColor,
                         foregroundColor: foregroundColor,
                         isPresented: $shouldShowFeedback)
        }
        .sheet(isPresented: $shouldShowChangeLog) {
            ChangelogView(primaryBackgroundColor: primaryBackgroundColor,
                          secondaryBackgroundColor: secondaryBackgroundColor,
                          foregroundColor: foregroundColor,
                          topicsViewModel: topicsViewModel,
                          isPresented: $shouldShowChangeLog)
        }
    }

    
    
    // MARK: - Variables
    
    @Environment(\.presentationMode) var presentationMode
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    @StateObject var topicsViewModel = RoadKitTopicsViewModel.shared
    
    @State var shouldShowFeedback = false
    @State var shouldShowChangeLog = false
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
    
    private func showChangelogSheet() {
        shouldShowChangeLog = true
    }
    
    private func dismissView() {
        presentationMode.wrappedValue.dismiss()
    }
    
}
