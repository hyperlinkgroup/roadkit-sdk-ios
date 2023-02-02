//
//  RoadkitManager.swift
//  
//
//  Created by Kevin Waltz on 02.02.23.
//

import Foundation
import Combine

public class RoadkitManager: ObservableObject {
    
    public static let shared = RoadkitManager()
    
    
    
    // MARK: - Variables
    
    public var topics = CurrentValueSubject<[Topic], Never>([])
    
    private let host = "https://europe-west3-roadkit-dev-swift.cloudfunctions.net"
    private var cancellable: AnyCancellable?
    
    private var projectID = ""
    private var userID = ""
    
    
    
    // MARK: - Functions
    
    /**
     Set the ID for your project and the current user's ID to fetch all available topics.
     
     The userID is used to check whether the current user voted for a topic. If no userID is provided, the value of "didVote" will always be `false`.
     
     - Parameter projectId: The ID of your app
     - Parameter userId: The ID of your currently logged in user
     */
    public func setProjectID(projectID: String, userID: String = "") {
        self.projectID = projectID
        self.userID = userID
        
        self.fetchTopics()
    }
    
    /**
     Fetch published topics for your project.
     */
    public func fetchTopics() {
        guard let request = createRequest() else {
            print("-----> URL request could not be created!")
            return
        }
        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode(code: (output.response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                
                return output.data
            }
            .decode(type: [Topic].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print(error.localizedDescription)
                }
            }, receiveValue: { [unowned self] topics in
                self.topics.send(topics)
                self.cancellable?.cancel()
            })
    }
    
    /**
     Create URL Request with data body.
     
     The url request uses a body to submit different variables needed by the backend to return published topics.
     */
    private func createRequest() -> URLRequest? {
        guard !projectID.isEmpty else {
            print("-----> No ProjectID available!")
            return nil
        }
        
        var urlComponents = URLComponents(string: host + projectID + userID)!
        
        guard let url = urlComponents.url else {
            print("-----> URL could not be created!")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
    
}
