FrameObserver is a framework that lets you attach observers to any `UIView` subclass and get notified when its size changes. It doesn't use any Method Swizzling or KVO so it'll be perfectly safe to use.

## Installation

###### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:
```
$ gem install cocoapods
```

Then, to add FrameObserver to your project, specify `FrameObserver` in your `Podfile`: 
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'FrameObserver'
end
```


## Usage

- Using closures:
```swift
view.addFrameObserver { frame, bounds in // get updates when the size of view changes
    print("frame", frame, "bounds", bounds)
}
```

- Using the delegate pattern:
```swift
class SomeViewController: UIViewController, FrameChangeDelegate {

    func frameChangeDelegateDidChange(for view: UIView, _ frame: CGRect, _ bounds: CGRect) {
        if view == self.view {
            print("frame", frame, "bounds", bounds)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addFrameObserver(with: self)
    }

}
```

You can call these on any `UIView` subclass, such as `UIButton`, `UIStackView`, etc.

The underlying implementation of this framework adds a totally invisibile, untappable view as a subview of the view you want to get notified about its frame. Thus, if you attach an observer to a `UIView` subclass, and for whatever reason remove all of its subviews, make sure you add the observer again.
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.addFrameObserver(with: self)

    for subview in view.subviews {
        subview.removeFromSuperview()
    }

    // the observer no longer exists, recreating it again
    view.addFrameObserver(with: self)
}

```

## Other functions: 
- `func removeObserver()`: Removes the current observer, if any. There's no need to call this in the `deinit` of your classes.
- `func hasFrameObserver() -> Bool`: Returns true if the view has a frame observer.


## License
FrameObserver is released under the MIT license. Check the LICENSE file for more details.
