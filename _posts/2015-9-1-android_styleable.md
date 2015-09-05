---
layout: post
title: Custom styleable
categories: Android
---

####Step

 - Code Custom View class
 - Code values/attrs.xml
 - Use custom attribute
 - Get attributes in custom view by TypedArray


####For example

> - Bubble.java(Custom view)

> - values/attrs.xml:

  ```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <declare-styleable name="Bubble">
        <attr name="arrowWidth" format="dimension"/>
        <attr name="angle" format="dimension"/>
        <attr name="arrowHeight" format="dimension"/>
        <attr name="arrowPosition" format="dimension"/>
        <attr name="bubbleColor" format="color"/>
        <attr name="arrowLocation" format="enum">
            <enum name="left" value="0x00"/>
            <enum name="top" value="0x01"/>
            <enum name="right" value="0x02"/>
            <enum name="bottom" value="0x03"/>
        </attr>
    </declare-styleable>
</resources>
  ```

> - layout files:

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    xmlns:me="http://schemas.android.com/apk/res-auto"
    android:paddingLeft="@dimen/activity_horizontal_margin"
    android:paddingRight="@dimen/activity_horizontal_margin"
    android:paddingTop="@dimen/activity_vertical_margin"
    android:paddingBottom="@dimen/activity_vertical_margin"
    tools:context=".MainActivity">

   <com.laudoak.bubble.BubbleLinerlayout
       android:layout_width="wrap_content"
       android:layout_height="wrap_content"
       me:arrowWidth="8dp"
       me:angle="0dp"
       me:arrowHeight="10dp"
       me:arrowPosition="20dp"
       me:arrowLocation="left"
       me:bubbleColor="#FFF">

       <TextView
           android:padding = "5dp"
           android:text="if you want to use more bubble ViewGroup, just extend ViewGroup and realize it like [`BubbleLinearLayout.java`](https://github.com/lguipeng/BubbleView/blob/master/library/src/main/java/com/github/library/bubbleview/BubbleLinearLayout.java). "
           android:layout_width="wrap_content"
           android:layout_height="wrap_content"
           android:layout_marginLeft="10dp"/>

   </com.laudoak.bubble.BubbleLinerlayout>

</RelativeLayout>

```

why using "me:...":
cause: namespace 
```xml
xmlns:me="http://schemas.android.com/apk/res-auto"
```

when using "android:..." first we decalare the namesapce as:
```xml
xmlns:android="http://schemas.android.com/apk/res/android"
```

> - in Bubble.java(Custom view) 

```Java
    private void init(AttributeSet attrs)
    {
        if (null!= attrs)
        {
            TypedArray array = getContext().obtainStyledAttributes(attrs,R.styleable.Bubble);
            mArrowWidth = array.getDimension(R.styleable.Bubble_arrowWidth,BubbleDrawable.Builder.DEFAULT_ARROW_WITH);
            mArrowHeight = array.getDimension(R.styleable.Bubble_arrowHeight,
                    BubbleDrawable.Builder.DEFAULT_ARROW_HEIGHT);
            mAngle = array.getDimension(R.styleable.Bubble_angle,
                    BubbleDrawable.Builder.DEFAULT_ANGLE);
            mArrowPosition = array.getDimension(R.styleable.Bubble_arrowPosition,
                    BubbleDrawable.Builder.DEFAULT_ARROW_POSITION);
            bubbleColor = array.getColor(R.styleable.Bubble_bubbleColor,
                    BubbleDrawable.Builder.DEFAULT_BUBBLE_COLOR);

            int location = array.getInt(R.styleable.Bubble_arrowLocation, 0);
            mArrowLocation = BubbleDrawable.ArrowLocation.intToLocation(location);
            array.recycle();
        }
    }
```

####Values type

1. reference：参考某一资源ID。

(1)属性定义：
```
<declare-styleable name="名称">
    <attr format="reference" name="background" />
</declare-styleable>
```
（2）属性使用：
````
<ImageView
    android:layout_width="42dip"
    android:layout_height="42dip"
    android:background="@drawable/图片ID" />
```
2. color：颜色值。

（1）属性定义：
```
<declare-styleable name="名称">
    <attr format="color" name="textColor" />
</declare-styleable>
```
（2）属性使用：
```
<TextView
    android:layout_width="42dip"
    android:layout_height="42dip"
    android:textColor="#00FF00" />
```
3. boolean：布尔值

（1）属性定义：
```
<declare-styleable name="名称">
    <attr format="boolean" name="focusable" />
</declare-styleable>
```
（2）属性使用：
```
<Button
    android:layout_width="42dip"
    android:layout_height="42dip"
    android:focusable="true" />
```
4. dimension：尺寸值。

（1）属性定义：

```
<declare-styleable name="名称">
    <attr format="dimension" name="layout_width" />
</declare-styleable>
```
（2）属性使用：
```
<Button
    android:layout_width="42dip"
    android:layout_height="42dip" />
```
5. float：浮点值。

（1）属性定义：
```
<declare-styleable name="AlphaAnimation">
    <attr format="float" name="fromAlpha" />
    <attr format="float" name="toAlpha" />
</declare-styleable>
```
（2）属性使用：
```
<alpha
    android:fromAlpha="1.0"
    android:toAlpha="0.7" />
```
6. integer：整型值。
（1）属性定义：
```
<declare-styleable name="AnimatedRotateDrawable">
    <attr format="integer" name="frameDuration" />
    <attr format="integer" name="framesCount" />
</declare-styleable>
```
（2）属性使用：
```
<animated-rotate
    android:frameDuration="100"
    android:framesCount="12"
     />
```
7. string：字符串。

（1）属性定义：
```
<declare-styleable name="MapView">
    <attr format="string" name="apiKey" />
</declare-styleable>
```
（2）属性使用：
```
<com.google.android.maps.MapView
    android:layout_width="fill_parent"
    android:layout_height="fill_parent"
    android:apiKey="0jOkQ80oD1JL9C6HAja99uGXCRiS2CGjKO_bc_g" />
```
8. fraction：百分数。

（1）属性定义：
```
<declare-styleable name="RotateDrawable">
    <attr format="fraction" name="pivotX" />
    <attr format="fraction" name="pivotY" />
</declare-styleable>
```
（2）属性使用：
```
<rotate
    android:pivotX="200%"
    android:pivotY="300%"
    />
```
9. enum：枚举值。

（1）属性定义：
```
<declare-styleable name="名称">
    <attr name="orientation">
        <enum name="horizontal" value="0" />
        <enum name="vertical" value="1" />
    </attr>
</declare-styleable>
```
（2）属性使用：
```
<LinearLayout
    android:orientation="vertical" >
</LinearLayout>
```
10. flag：位或运算。

（1）属性定义：
```
<declare-styleable name="名称">
    <attr name="windowSoftInputMode">
        <flag name="stateUnspecified" value="0" />
        <flag name="stateUnchanged" value="1" />
        <flag name="stateHidden" value="2" />
        <flag name="stateAlwaysHidden" value="3" />
        <flag name="stateVisible" value="4" />
        <flag name="stateAlwaysVisible" value="5" />
        <flag name="adjustUnspecified" value="0x00" />
        <flag name="adjustResize" value="0x10" />
        <flag name="adjustPan" value="0x20" />
        <flag name="adjustNothing" value="0x30" />
    </attr>
</declare-styleable>
```
（2）属性使用：
```
<activity
    android:windowSoftInputMode="stateUnspecified | stateUnchanged　|　stateHidden" >
</activity>
```


注意：属性定义时可以指定多种类型值：

（1）属性定义：
```
<declare-styleable name="名称">
    <attr format="reference|color" name="background" />
</declare-styleable>
```
（2）属性使用
```
<ImageView
    android:layout_width="42dip"
    android:layout_height="42dip"
    android:background="@drawable/图片ID|#00FF00" />
```