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
Don't use the Xcode 9 beta version, and there will be errors in this version.
## Hardware ESP8266 NodeMCU Code init.lua Test
```
wifi.setmode(wifi.STATION)  
-- 0 is esptouch;
-- 1 is airkiss;
wifi.startsmart(0,  
    function(ssid, password)

        -- print log
        print(string.format("Success. SSID:%s ; PASSWORD:%s", ssid, password))

        -- write wifi ssid and pass to txt
        file.open("wifi.txt", "w+")
        file.write(ssid)
        file.close()

        file.open("pass.txt", "w+")
        file.write(password)
        file.close()

    end
)
```
