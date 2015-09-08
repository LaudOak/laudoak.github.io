---
layout: post
title: "rotate & ProgressBar"
categories: Android
---

###Change ProgressBar's color

 > drawable/progress.xml(rotate)

```xml
<?xml version="1.0" encoding="utf-8"?>
<rotate xmlns:android="http://schemas.android.com/apk/res/android"
    android:fromDegrees="0"
    android:pivotX="50%"
    android:pivotY="50%"
    android:toDegrees="360" >

    <shape
        android:innerRadiusRatio="3"
        android:shape="ring"
        android:thicknessRatio="8"
        android:useLevel="false" >
        <size
            android:height="76dip"
            android:width="76dip" />

        <gradient
            android:angle="0"
            android:endColor="#000"
            android:startColor="@android:color/transparent"
            android:type="sweep"
            android:useLevel="false" />
    </shape>

</rotate>
```

 > in layout file 

 ```xml
 <ProgressBar
        android:id="@+id/progress"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:indeterminate="true"
        android:indeterminateDrawable="@drawable/progress" />
 ```

 