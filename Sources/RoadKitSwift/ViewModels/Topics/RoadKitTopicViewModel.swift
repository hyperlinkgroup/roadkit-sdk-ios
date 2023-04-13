//
//  RoadKitTopicViewModel.swift
//  RoadKit
//
//  Created by Kevin Waltz on 13.04.23.
//

import SwiftUI
import Combine

class RoadKitTopicViewModel: RoadKitObjectViewModel<RoadKitTopic> {
    
    // MARK: - Init
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(topic: RoadKitTopic) {
        super.init(object: topic)
    }
    
    
    
    // MARK: - Variables
    
    var id: String { object.topicId }
    
    
    
    // MARK: - Functions
    
    func voteFeature() {
        RoadKitManager.shared.voteTopic(topicId: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Successfully voted!")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { _ in
                RoadKitManager.shared.fetchTopics()
            })
            .store(in: &cancellables)
    }
    
}
