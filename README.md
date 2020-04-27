# SmartConfig
SmartConfig is an ESP board auto connect WiFi demo written in Swift.

## Requirements
- iOS 8.0+
- Xcode 8.0+
- Swift 3.0
## Bridge ESPtouch lib
1.Xcode -> Create a new Xcode project -> Single View App.  
2.Download lib [https://github.com/EspressifApp/LibEsptouchForIOS](https://github.com/EspressifApp/LibEsptouchForIOS).  
3.Move libEsptouch_v0.3.5.3.a, ESPTouchTask.h, ESPTouchResult.h, ESPTouchDelegate.h to your new project.  
![](https://github.com/lou-lan/SmartConfig/blob/master/images/1.png) 
4.In project group finder, create a new fire, select Objecttive-C file, then select Create Bridging Header.  
![](https://github.com/lou-lan/SmartConfig/blob/master/images/2.png) 
5.In Demo-Bridging-Header.h file, import lib.  
![](https://github.com/lou-lan/SmartConfig/blob/master/images/3.png) 
```
#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESPTouchDelegate.h"
```
## Hardware ESP8266 NodeMCU Code init.lua Test
```lua
print("Start SmartConfig ...")
wifi.setmode(wifi.STATION)
wifi.startsmart(0,
    function(ssid, password)
        print(string.format("Success. SSID:%s ; PASSWORD:%s", ssid, password))
        print("Back init.lua")
        dofile("init.lua")
    end
)
```

## TODO
[ ] SwiftUI
[ ] WiFi 5G

