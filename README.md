# SmartConfig
SmartConfig is an ESP board auto connect WiFi demo written in Swift.

## Requirements
- iOS 8.0+
- Xcode 8.0+
- Swift 3.0
## Create an Demo
1.Xcode -> Create a new Xcode project -> Single View App.  
2.Download lib [https://github.com/EspressifApp/LibEsptouchForIOS](https://github.com/EspressifApp/LibEsptouchForIOS).  
3.Move libEsptouch_v0.3.5.3.a, ESPTouchTask.h, ESPTouchResult.h, ESPTouchDelegate.h to your new project.  
4.In project group finder, create a new fire, select Objecttive-C file, then select Create Bridging Header.  
5.In Demo-Bridging-Header.h file, import lib.  
```
#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESPTouchDelegate.h"
```



