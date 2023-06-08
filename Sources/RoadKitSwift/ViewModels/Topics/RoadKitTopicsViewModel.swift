//
//  RoadKitTopicsViewModel.swift
//  RoadKit
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI
import Combine
import Collections

class RoadKitTopicsViewModel: ObservableObject, Identifiable {
    
    static let shared = RoadKitTopicsViewModel()
    
    
    // MARK: - Init
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        roadkitManager.fetchTopics()
        
        roadkitManager.topics
            .dropFirst()
            .sink { [unowned self] topics in
                self.featureViewModels = topics
                    .filter { $0.type == RoadKitTopicType.feature.rawValue && $0.status != RoadKitTopicStatus.done.rawValue }
                    .sorted { $0.title < $1.title }
                    .map { RoadKitTopicViewModel(topic: $0) }
                
                self.improvementViewModels = topics
                    .filter { $0.type == RoadKitTopicType.improvement.rawValue && $0.status != RoadKitTopicStatus.done.rawValue }
                    .sorted { $0.title < $1.title }
                    .map { RoadKitTopicViewModel(topic: $0) }
                
                self.bugViewModels = topics
                    .filter { $0.type == RoadKitTopicType.bug.rawValue && $0.status != RoadKitTopicStatus.done.rawValue }
                    .sorted { $0.title < $1.title }
                    .map { RoadKitTopicViewModel(topic: $0) }
                
                
                let topicViewModels = topics
                    .filter { $0.status == RoadKitTopicStatus.done.rawValue }
                    .map { RoadKitTopicViewModel(topic: $0) }
                
                var changelogViewModels = OrderedDictionary(grouping: topicViewModels) { $0.object.version ?? "-" }
                    .map { RoadKitChangelogViewModel(version: $0.key, topicViewModels: $0.value) }
                changelogViewModels.sort { $0.version > $1.version }
                
                self.changelogViewModels = changelogViewModels
                
                self.didFetchTopics = true
            }
            .store(in: &cancellables)
    }
    
    
    
    // MARK: - Variables
    
    @ObservedObject var roadkitManager = RoadKitManager.shared
    
    @Published var featureViewModels = [RoadKitTopicViewModel]()
    @Published var improvementViewModels = [RoadKitTopicViewModel]()
    @Published var bugViewModels = [RoadKitTopicViewModel]()
    
    @Published var changelogViewModels = [RoadKitChangelogViewModel]()
    
    @Published var didFetchTopics = false
    
    
    
    // MARK: - Functions
    
    func sendFeedback(type: RoadKitTopicType, description: String) {
        roadkitManager.submitTopic(type: type, description: description)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Successfully submitted!")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { _ in
            })
            .store(in: &cancellables)
    }
    
}
