---
layout: post
title: Appcompat ActionBar Style
categories: Android
---

####Reference

[CUSTOM COLOR IN ACTION BAR + DRAWER](http://belencruz.com/2015/04/custom-colors-in-action-bar-drawer/)

[Remove shadow below actionbar](http://stackoverflow.com/questions/12246388/remove-shadow-below-actionbar)

[Strange divider with the v7 support actionbar](http://stackoverflow.com/questions/18737419/strange-divider-with-the-v7-support-actionbar)

[Remove shadow below actionbar](http://stackoverflow.com/questions/12246388/remove-shadow-below-actionbar)

####Conclusion

 - Remove shadow below ActionBar

 ```xml
 <style name="AppTheme" parent="Theme.AppCompat.Light.DarkActionBar">
        <item name="actionBarStyle">@style/CustomActionBar</item>
        <item name="android:windowContentOverlay">@null</item>
    </style>

    <style name="CustomActionBar" parent="Base.Widget.AppCompat.ActionBar">
        <item name="background">@color/white</item>
    </style>
 ```

 

