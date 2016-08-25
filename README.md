# KeyboardAnimatable

A protocol-oriented library for performing animation when toggling keyboard

![Language](https://img.shields.io/badge/language-Swift%203.0-orange.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/KeyboardAnimatable.svg?style=flat)](http://cocoadocs.org/docsets/KeyboardAnimatable/)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![License](https://img.shields.io/github/license/JeromeTan1997/KeyboardAnimatable.svg?style=flat)

* [Installation](#installation)
    - [Cocoapods](#cocoapods)
    - [Carthage](#carthage)
    - [Swift Package Manager](#swift-package-manager)
    - [Manually](#manually)
* [Usage](#usage)
* [License](#license)

## Installation

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate `KeyboardAnimatable` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'YourApp' do
    pod 'KeyboardAnimatable'
end
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate `KeyboardAnimatable` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "JeromeTan1997/KeyboardAnimatable"
```

### Swift Package Manager

[Swift Package Manager](#https://swift.org/package-manager/) is a tool for managing the distribution of Swift code.

To integrate `KeyboardAnimatable` into your Xcode project using Swift Package Manager, specify it in your `Packages.swift`:

```swift
import PackageDescription

let package = Package(
    name: "Your Project Name",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/JeromeTan1997/KeyboardAnimatable.git", versions: "1.0" ..< Version.max)
    ]
)
```

## usage

```swift
import UIKit
import KeyboardAnimatable

class ViewController: UIViewController, KeyboardAnimatable {

    override func viewDidLoad() {
        super.viewDidLoad()

        enableKeyboardAnimation()
    }

    deinit {
        disableKeyboardAnimation()
    }


    func animateWhenKeyboardAppear(keyboardHeight keyboardHeight: CGFloat, duration: NSTimeInterval) {
        UIView.animateWithDuration(duration) {
            // perform animation
        }
    }

    func animateWhenKeyboardDisappear(keyboardHeight keyboardHeight: CGFloat, duration: NSTimeInterval) {
        UIView.animateWithDuration(duration) {
            // perform animation
        }
    }

}
```

## License

The MIT License (MIT)

Copyright (c) 2016 Jerome Tan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
