---
layout: post
title: ADB not responding
category: 云雀
---

### ADB not responding. If you'd like to retry, then please manually kill “adb.exe” and click 'Restart'

#### Resolve:

* The adb using port "5037"

* open cmd type in 'netstat -ano|findstr "5037" '

* find port 5037 is occupied by 'shuame_help.exe'

* kill the shuame_help.exe and the adb it will returned to normal
