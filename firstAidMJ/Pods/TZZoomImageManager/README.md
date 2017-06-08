# TZZoomImageManager

[![CI Status](http://img.shields.io/travis/Tzoani/TZZoomImageManager.svg?style=flat)](https://travis-ci.org/Tzoani/TZZoomImageManager)
[![Version](https://img.shields.io/cocoapods/v/TZZoomImageManager.svg?style=flat)](http://cocoapods.org/pods/TZZoomImageManager)
[![License](https://img.shields.io/cocoapods/l/TZZoomImageManager.svg?style=flat)](http://cocoapods.org/pods/TZZoomImageManager)
[![Platform](https://img.shields.io/cocoapods/p/TZZoomImageManager.svg?style=flat)](http://cocoapods.org/pods/TZZoomImageManager)

[![](https://dl.dropboxusercontent.com/s/jbk1xd4pw2m2czd/iPhone_Modal.png)](iPhone_Modal.png)
[![](https://dl.dropboxusercontent.com/s/bunor887yg8gs45/iPhone_Push.png)](iPhone_Push.png)
[![](https://dl.dropboxusercontent.com/s/yzuu6pcfucbzqh6/iPad_PopOver.png)](iPad_PopOver.png)

## Usage

```ObjC
  - (IBAction)pressPushAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    
    [[ZoomImageManager defadefaultManager] zoomWithImage:[UIImage imageNamed:@"photo"] onView:button inController:self isNavigation:YES];
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

TZZoomImageManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TZZoomImageManager"
```

## Author

Tzoani, darksky_ddd@hotmail.com
Nizaii, lalida.jar@gmail.com

## License

TZZoomImageManager is available under the MIT license. See the LICENSE file for more info.
