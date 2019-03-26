// WatchMaker, Made in 🇫🇷 with ❤️ by Sylvain Guillier for WWDC19 Scholarship.

import PlaygroundSupport
import UIKit

let width = 736
let height = 414

// Set up the home view
let home = HomeViewController()
home.preferredContentSize = CGSize(width: width, height: height)

// Welcome voice
Speaker.sharedInstance.speak(string: "Hello and welcome to WatchMaker. We need to build an original watch before the WWDC...")

// Background song
MusicManager.sharedInstance.setup()

// Show Playground live view
PlaygroundPage.current.liveView = home
