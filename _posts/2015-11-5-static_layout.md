---
layout: post
title: Android StaticLayout
categories: Android
---

 ### Android Android StaticLayout

 #### Public Constructors

 ```
 public StaticLayout(CharSequence source,
                    TextPaint paint,
                    int width,
                    Layout.Alignment align,
                    float spacingmult,
                    float spacingadd,
                    boolean includepad)
                    
public StaticLayout(CharSequence source,
                    int bufstart,
                    int bufend,
                    TextPaint paint,
                    int outerwidth,
                    Layout.Alignment align,
                    float spacingmult,
                    float spacingadd,
                    boolean includepad)
                    
public StaticLayout(CharSequence source, // 字符串子资源
                    int bufstart,
                    int bufend,
                    TextPaint paint,//画笔对象
                    int outerwidth, //layout的宽度，字符串超出宽度时自动换行。

                    /*Layout.Alignment align,layout的样式，有ALIGN_CENTER，ALIGN_NORMAL， ALIGN_OPPOSITE 三种。*/
                    Layout.Alignment align,

                    /*相对行间距，相对字体大小，1.5f表示行间距为1.5倍的字体高*/
                    float spacingmult,
                    /*相对行间距，0表示0个像素,实际行间距等于这两者的和。*/
                    float spacingadd,
                    boolean includepad,
                    TextUtils.TruncateAt ellipsize,
                    int ellipsizedWidth)
 ```

 