import UIKit

public struct FramerExample {
    public let title: String
    public let author: String
    public let URL: NSURL
    public let image: UIImage
    
    init(title: String, author: String, URL: NSURL, image: UIImage) {
        self.title = title
        self.author = author
        self.URL = URL
        self.image = image
    }
    
    init(_ title: String, _ author: String, _ URL: String, _ imagePath: String) {
        self.init(title: title, author: author, URL: NSURL(string: URL)!, image: UIImage(named: imagePath)!)
    }
    
}

extension FramerExample: CustomStringConvertible {
    public var description: String {
        return title
    }
}

public struct ExampleDataSource {
    public var data: [FramerExample] = [
        FramerExample("Watch Glances", "Benjamin den Boer", "http://framerjs.com/gallery/preview/#glances.framer", "glances-poster.jpg"),
        FramerExample("Facebook Live", "George Kedenburg III", "http://share.framerjs.com/zmiyvyehoc5c/", "fb-live-poster.jpg"),
        FramerExample("Clear To Do", "Robert van Klinken", "http://share.framerjs.com/wt409xsavwj9/", "todo-poster.jpg"),
        FramerExample("Album View Switch", "Anton Kartashov", "http://share.framerjs.com/c3rh3y31ot4v/", "album-view-poster.jpg"),
        
        FramerExample("Photo View", "Benjamin den Boer", "http://share.framerjs.com/suy7bpnvk21e/", "photo-view-poster.jpg"),
        FramerExample("Apple Watch Clock", "Robert van Klinken", "http://share.framerjs.com/yn5vvzie72cm/", "watch-clock-poster.jpg"),
        FramerExample("Google Inbox", "Amine Zafri", "http://share.framerjs.com/bzpo9tjihd8l/", "google-inbox-poster.jpg"),
        FramerExample("Internet of Things", "Balraj Chana", "http://share.framerjs.com/u3g0tj8pyyxv/", "iot-poster.jpg"),
        FramerExample("Map Exploration", "Claudio Guglieri", "http://share.framerjs.com/rkkr864x1pzu/", "map-exploration-poster.jpg"),
        FramerExample("Travel App Menu", "Alex Murashko", "http://share.framerjs.com/tpa9yj5cn8sn/", "travel-app-poster.jpg"),
        FramerExample("Sign-up Flow", "Djorde Vanjek", "http://share.framerjs.com/w79jkv3n7ezj/", "signupflow-poster.jpg"),
        FramerExample("Shazam Track Page", "Alex Steven", "http://framerjs.com/gallery/preview/#shazam-track-page.framer", "shazam-poster.jpg"),
        FramerExample("Watchlist", "Krijn Rijshouwer", "http://share.framerjs.com/vv545umshkxi/", "watchlist-poster.jpg"),
        FramerExample("Pinch and Pan", "Benjamin den Boer", "http://share.framerjs.com/g0csfrca75ko/", "pinch-poster.jpg"),
        FramerExample("Voice Onboarding", "Noah Levin", "http://framerjs.com/gallery/preview/#voice-onboarding.framer", "voice-onboarding-poster.jpg"),
        FramerExample("Apple TV Icon", "Robert van Klinken", "http://framerjs.com/gallery/preview/#apple-tv-icon.framer", "apple-tv-icon-poster.jpg")
        
    ]
    
    public init() {}
}


