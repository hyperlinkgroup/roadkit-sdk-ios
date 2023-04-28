//
//  RoadKitManager.swift
//  
//
//  Created by Kevin Waltz on 02.02.23.
//

import Foundation
import Combine

public class RoadKitManager: ObservableObject {
    
    public static let shared = RoadKitManager()
    
    
    
    // MARK: - Variables
    
    public var topics = CurrentValueSubject<[RoadKitTopic], Never>([])
    private var cancellable: AnyCancellable?
    
    private var projectID = ""
    private var userID = ""
    
    private var anonymousUserID: String? {
        get { UserDefaults.standard.string(forKey: "anonymousUserID") }
        set { UserDefaults.standard.set(newValue, forKey: "anonymousUserID") }
    }
    
    
    
    // MARK: - Functions
    
    /**
     Set the ID for your project and the current user's ID to fetch all available topics.
     
     The userID is used to check whether the current user voted for a topic. If no userID is provided, the value of "didVote" will always be `false`.
     
     - Parameter projectId: The ID of your app
     - Parameter mode: Setup RoadKit anonymously if you have no user ID
     - Parameter userId: Required if you select "userID" as method
     */
    public func setupRoadKit(projectID: String, mode: SetupMode, userID: String? = nil) {
        self.projectID = projectID
        
        switch mode {
        case .anonymous:
            switchToAnonymousMode()
        case .userID:
            guard let userID else {
                fatalError("RoadKit not initialised: No userID provided.")
            }
            switchToUserIDMode(userID: userID)
        }
    }
    
    public func switchToAnonymousMode() {
        let anonymousUserID = self.anonymousUserID ?? UUID().uuidString
        self.userID = anonymousUserID
        self.anonymousUserID = anonymousUserID
    }
    
    public func switchToUserIDMode(userID: String) {
        self.userID = userID
        self.anonymousUserID = nil
    }
    
    public func updateUserID(with userID: String) {
        guard userID != self.userID else { return }
        switchToUserIDMode(userID: userID)
    }
    
    /**
     Create URL Request with data body.
     
     The url request uses a body to submit different variables needed by the backend.
     */
    private func createRequest(method: HTTPMethod, route: Routes, topic: NewRoadKitTopic? = nil) -> URLRequest? {
        checkCredentials()
        
        var request = URLRequest(url: route.url)
        request.httpMethod = method.httpMethod
        
        if let topic {
            var headers = request.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = headers
            request.httpBody = try? JSONEncoder().encode(topic)
        }
        
        return request
    }
}



// MARK: - Fetch Topics
extension RoadKitManager {
    /**
     Fetch published topics for your project.
     */
    public func fetchTopics() {
        let route = Routes(endpoint: .topics, projectID: projectID, userID: userID)
        
        guard let request = createRequest(method: .get, route: route) else {
            print("-----> URL request could not be created!")
            return
        }
        
        self.cancellable = URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode(code: (output.response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                
                return output.data
            }
            .decode(type: [RoadKitTopic].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }) { [unowned self] topics in
                self.topics.send(topics)
                self.cancellable?.cancel()
            }
    }
}


// MARK: - Vote Topic
extension RoadKitManager {
    /**
     Vote for a specific topic.
     
     Votes are submitted for features and bugs, but our Client only shows votes for features, so it's better to restrict voting to features on the user side.
     
     - Parameter topicId: The ID of the topic to be upvoted
     - Parameter userId: The current user's ID (a string must be passed which is not empty)
     */
    public func voteTopic(topicId: String) -> AnyPublisher<String, Error> {
        let route = Routes(endpoint: .vote, topicID: topicId, userID: userID)
        
        guard let request = createRequest(method: .put, route: route) else {
            print("-----> URL request could not be created!")
            return Fail(error: NSError(domain: "URL request could not be created", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200,
                      let dataString = String(data: output.data, encoding: .utf8) else {
                    
                    throw HTTPError.statusCode(code: (output.response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                
                return dataString
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - Submit Topic
extension RoadKitManager {
    /**
     Post a topic to RoadKit.
     
     - Parameter type: TopicType (Feature or Bug)
     - Parameter title: A short summary
     - Parameter description: Detailed info on the topic (optional)
     */
    public func submitTopic(type: RoadKitTopicType, description: String) -> AnyPublisher<String, Error> {
        let route = Routes(endpoint: .topics, projectID: projectID, userID: userID)
        let newTopic = NewRoadKitTopic(type: type.rawValue, description: description)
        
        guard let request = createRequest(method: .post, route: route, topic: newTopic) else {
            print("-----> URL request could not be created!")
            return Fail(error: NSError(domain: "URL request could not be created", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200,
                      let dataString = String(data: output.data, encoding: .utf8) else {
                    
                    throw HTTPError.statusCode(code: (output.response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                
                return dataString
            }
            .eraseToAnyPublisher()
    }
}


// MARK: - Error
extension RoadKitManager {
    /**
     ProjectID and userID need to be provided, otherwise an error will be thrown.
     */
    private func checkCredentials() {
        guard !projectID.isEmpty, !userID.isEmpty else {
            fatalError("RoadKit not initialised: No projectID or userID provided.")
        }
    }
}
