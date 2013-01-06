# ios-client

This is all the code for the iOS client application.

## Technologies used

- [Xcode 4.2](https://developer.apple.com/xcode/) running on Snow Leopard, on an ancient MacBook.
- [Automatic Reference Counting (ARC)](https://developer.apple.com/library/mac/#releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226).
- [Storyboards](http://developer.apple.com/library/ios/#releasenotes/Miscellaneous/RN-AdoptingStoryboards/_index.html).

## Third party libraries and tools used

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) for all networking operations. I created an AFHTTPClient subclass to handle all the requests.
- [SVProgressHUD](https://github.com/samvermette/SVProgressHUD) for the nice progress HUDs. I created a category to encapsulate it too.
- [TPKeyboardAvoiding](https://github.com/michaeltyson/TPKeyboardAvoiding) to handle the keyboard in an easy and clean way.
- [ISO8601DateFormatter](https://github.com/keithpitt/ISO8601DateFormatter) to handle ISO 8601 date parsing.

## Coming soon

- Finishing the application.
- Beautiful UI.
- [SenTestingKit](http://developer.apple.com/library/ios/#documentation/DeveloperTools/Conceptual/UnitTesting/00-About_Unit_Testing/about.html#//apple_ref/doc/uid/TP40002143) for automated tests.
- Code review and refactoring.