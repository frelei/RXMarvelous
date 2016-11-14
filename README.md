# Marvelous

Marvelous is a simple sample where I show the caracthers of the Marvel Comics!! 
In this sample, I am using RxSwift to demostrate some funcionalities of the framework applying Reactive and functional programing concepts. 


### Pre-requisites:
- iOS 10.0+
- Xcode 8.0+
- Swift 3.0+
- [CocoaPods](https://cocoapods.org/)
- [Swiftlint](https://github.com/realm/SwiftLint)

### Swiftlint
[Swiftlint](https://github.com/realm/SwiftLint) is a tool to enforce swift style and conventions. 
To install the tool, just donwload the [swiftLint.pkg](https://github.com/realm/SwiftLint/releases/download/0.13.0/SwiftLint.pkg) and running it.

After the installation, go to XCode in the build phase tab and add a new "Run Script Phase" and type

```bash
if which swiftlint >/dev/null; then
swiftlint
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
```

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required

Then, Install dependencies running the following command:

```bash
$ pod install
```
> Make sure you are in the project root folder


### Frameworks

This app uses the [Marvel API] (https://developer.marvel.com). So go to the there register and create your key!



### Screens

![Screen1](http://i.imgur.com/F0KbV8h.png)
![Screen2](http://i.imgur.com/lZQY5GI.png)
![Screen1](http://i.imgur.com/0PsUyPb.png)
