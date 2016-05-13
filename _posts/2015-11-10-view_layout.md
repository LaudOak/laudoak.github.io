---
layout: post
title:  "Android layout"
categories: Android
---

```
@Override
protected abstract void onLayout(boolean changed,
            int l, int t, int r, int b);
```

ViewGroup中的抽象函数，继承该类必须实现onLayout方法，而ViewGroup的onMeasure并非必须重写的。View的放置都是根据一个矩形空间放置的，onLayout传下来的l,t,r,b分别是放置父控件的矩形可用空间（除去margin和padding的空间）的左上角的left、top以及右下角right、bottom值。

```
public void layout(int l, int t, int r, int b);
```

该方法是View的放置方法，在View类实现。调用该方法需要传入放置View的矩形空间左上角left、top值和右下角right、bottom值。这四个值是相对于父控件而言的。例如传入的是（10, 10, 100, 100），则该View在距离父控件的左上角位置(10, 10)处显示，显示的大小是宽高是90(参数r,b是相对左上角的)，这有点像绝对布局。

```
public class MyViewGroup extends ViewGroup {
 
    // 子View的水平间隔
    private final static int padding = 20;
     
    public MyViewGroup(Context context, AttributeSet attrs) {
        super(context, attrs);
        // TODO Auto-generated constructor stub
    }
 
    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        // TODO Auto-generated method stub
         
        // 动态获取子View实例
        for (int i = 0, size = getChildCount(); i < size; i++) {
            View view = getChildAt(i);
            // 放置子View，宽高都是100
            view.layout(l, t, l + 100, t + 100);
            l += 100 + padding;
        }
         
    }
     
}
```

```
<relativelayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:tools="http://schemas.android.com/tools" android:layout_width="match_parent" android:layout_height="match_parent" android:padding="10dp">
 
    <com.example.layout.myviewgroup android:layout_width="match_parent" android:layout_height="100dp" android:background="#0000ff">
         
        <view android:layout_width="match_parent" android:layout_height="match_parent" android:background="#ff0000">
        <view android:layout_width="match_parent" android:layout_height="match_parent" android:background="#00ff00">
         
    </view></view></com.example.layout.myviewgroup>
 
</relativelayout>
```

![](/resources/image/viewlayout.PNG)