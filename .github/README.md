# Roadkit

Roadkit enables you to track user feedback for iOS and macOS apps. You can easily integrate the SDK into all of your apps to receive feedback and show what features and bugs your are currently working on. Our voting feature enables you to track which new features are important to your users. Additionally, you can display a changelog to let everyone know how far your app has come.


---


## Content
- [Features](#features)
- [Installation](#installation)
- [How to Use](#how-to-use)


## Features
- [x] Fetch open topics for your app
- [x] Post a new topic (Feature, Improvement or Bug)
- [x] Vote for a topic
- [x] Undo votes for a topic
- [x] Get if the current user has voted for a topic


## Installation
#### Requirements
The SDK requires an account for Roadkit with a registered project.

- iOS 14.0+ / macOS 12.0
- Xcode 13+
- Swift 5+

#### Swift Package Manager
In Xcode, go to `File > Add Packages` and add `https://github.com/hyperlinkgroup/roadkit-sdk-ios`. Add the package to your desired targets.


## How to Use
#### Setup
To setup Roadkit, you need to initialize the SDK with your project's ID and a UserID. The ProjectID can be found in your macOS app, in the info tab of the app. The UserID is the ID of your current user. To setup Roadkit you need to `import Roadkit` on top of your file and then call:
```Swift
RoadkitManager.shared.setupRoadkit(projectID: <String>, userID: <String>)
```

If your user changes, you can call the following function to update the UserID:
```Swift
RoadkitManager.shared.updateUserID(with: <String>)
```

**Important**: The UserID is optional and if you don't provide one, it will be sent as an empty string. We strongly recommend sending a UserID (if you don't authenticate your users, you can create a UUID and store it in your UserDefaults or Keychain). Keep in mind that if no ID is provided, the check wether your user has voted for a specific topic will always return false and voting does not work.

#### Fetching Topics
All published topics are fetched and kept in the `RoadKitManager` within the package.
To fetch topics you need to `import Roadkit` on top of your file and call:
```Swift
RoadkitManager.shared.fetchTopics()
```
This can be done from any file you want. Topics are stored as a `CurrentValueSubject` using the `Combine` framework. It is best to use combine to read the values by using the `.sink` method and store the results. An example using SwiftUI would be:
```Swift
@ObservedObject var roadkitManager = RoadkitManager.shared
private var cancellables = Set<AnyCancellable>()

roadkitManager.topics
    .sink { [weak self] topics in
        <Do something with the topics>
    }
    .store(in: &cancellables)
```

Our RoadKitManager is an `@ObservedObject`, so `.sink` gets called again when the array of topics changes.

**Important**: Combine allows to observe changes on the topics array from the `CurrentValueSubject`, but Roadkit does not support realtime updates. It only gets updated after calling `fetchTopics()` again.

#### Posting a topic
To post a new topic, you only need to submit the type and the topic's description:
```Swift
RoadkitManager.shared.submitTopic(type: <TopicType>, description: <String>)
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
```
The TopicType is an enum and you can set it as `.feature, .improvement or .bug` (you can change the type later in your macOS app). The description is a string, which should be provided by your user by entering text. As soon as it is submitted it will appear in realtime in your macOS app.

**Important**: The default state for a new topic is that it is NOT published. It will only appear in your macOS app, from where you can edit it and publish it to be seen by your users.

#### Vote for a topic
To vote a topic you need to pass the TopicID (which you can access from the topic model) and call the following function:
```Swift
RoadkitManager.shared.voteTopic(topicId: <String>)
    .sink(receiveCompletion: { completion in
      switch completion {
        case .finished:
          print("Successfully voted!")
        case .failure(let error):
          print(error.localizedDescription)
        }
    }, receiveValue: { _ in
        RoadkitManager.shared.fetchTopics()
    })
    .store(in: &cancellables)
```

After voting for a topic, it makes sense to call `fetchTopics()` again, because you will now receive the updated value that your user has voted for the topic, so you can display them within your app accordingly.

**Important**: If your user has voted for a topic before, the vote will be undone. Voting will not work if you don't provide a UserID.
