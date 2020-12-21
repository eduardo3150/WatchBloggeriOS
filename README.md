# WatchBlogger iOS

### Overview

The purpose of this application is to demostrate the usage of `Realm` and `Alamofire` to build and application that allows the user to see watches articles from `NewsAPI`

### Installation

Once you clone this repository make sure you are running on `Xcode 12.3` or newer and have [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) installed.

The next step would be to run `pod install` to download all the dependencies the app will use, and finally check the project by opening `WatchBloggeriOS.xcworkspace`

The next step would be to add your own API key inside the [Constants](/WatchBloggeriOS/Constants.swift) file, for simplicity of this demo, you will find my own API key inside the [env.sample](./env.sample) file

### Testing

The current state of the application has testing coverage for the Realm database controller, more updates to come soon.

Testing stack consist of:

- [Quick](https://github.com/Quick/Quick.git)
- [Nimble](https://github.com/Quick/Nimble)
- [Spry](https://github.com/Rivukis/Spry)
