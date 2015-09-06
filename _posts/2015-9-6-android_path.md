---
layout: post
title: Path & Bubble path
categories: Android
---

###Path usage
 - lineTo()
 ```
mPath.moveTo(100, 100);
mPath.lineTo(300, 300);
canvas.drawPath(mPath, mPaint);
 ```

 ![#](/resources/image/2015-9-1-android_path/lineTo.jpg)

 - quadTo()

quadTo() 用于绘制圆滑曲线，即贝塞尔曲线mPath.moveTo(100, 500);
mPath.quadTo(x1, y1, x2, y2) (x1,y1) 为控制点，(x2,y2)为结束点

```
mPath.quadTo(300, 100, 600, 500);
canvas.drawPath(mPath, mPaint);
```

![](/resources/image/2015-9-1-android_path/quadTo.jpg)

- cubicTo()

mPath.cubicTo(x1, y1, x2, y2, x3, y3)  (x1,y1)，(x2,y2)为控制点，(x3,y3) 为结束点

```
mPath.moveTo(100, 500);
mPath.cubicTo(100, 500, 300, 100, 600, 500);
```

![](/resources/image/2015-9-1-android_path/quadTo.jpg)

 - arcTo()

 arcTo 绘制弧线（截取圆或椭圆的一部分）

 mPath.arcTo(ovalRectF, startAngle, sweepAngle) , ovalRectF为椭圆的矩形，startAngle 为开始角度，sweepAngle 为结束角度

 mRectF = new RectF(10, 10, 600, 600);
 mPath.arcTo(mRectF, 0, 90);
 canvas.drawPath(mPath, mPaint);
 由于new RectF(10, 10, 600, 600)为正方形，又截取 0 ~ 90 度 ，则所得曲线为四分之一圆的弧线

 ```
mRectF = new RectF(10, 10, 600, 600);
mPath.arcTo(mRectF, 0, 90);
canvas.drawPath(mPath, mPaint);
 ```

 ![](/resources/image/2015-9-1-android_path/arcTo.jpg)

 ![](/resources/image/2015-9-1-android_path/arcTo2.jpg)

###Bubble Path

```
path.moveTo(mArrowWidth + rect.left + mAngle, rect.top);
        path.lineTo(rect.width() - mAngle, rect.top);

        /**
         *arcTo(RectF oval, float startAngle, float sweepAngle)
         *Append the specified arc to the path as a new contour.
         */
        path.arcTo(new RectF(rect.right - mAngle , rect.top, rect.right,
                mAngle + rect.top), 270, 90);
        path.lineTo(rect.right, rect.bottom - mAngle);

        path.arcTo(new RectF(rect.right - mAngle , rect.bottom - mAngle,
                rect.right, rect.bottom), 0, 90);
        path.lineTo(rect.left + mArrowWidth + mAngle, rect.bottom);

        path.arcTo(new RectF(rect.left + mArrowWidth, rect.bottom - mAngle ,
                mAngle + rect.left + mArrowWidth, rect.bottom), 90, 90);
        path.lineTo(rect.left + mArrowWidth,  mArrowHeight + mArrowPosition);

        path.lineTo(rect.left, mArrowPosition + mArrowHeight / 2);
        path.lineTo(rect.left + mArrowWidth, mArrowPosition);
        path.lineTo(rect.left + mArrowWidth, rect.top + mAngle);
        path.arcTo(new RectF(rect.left + mArrowWidth, rect.top, mAngle
                + rect.left + mArrowWidth, mAngle + rect.top), 180, 90);
        path.close();
```

![](/resources/image/2015-9-1-android_path/bubble_path.png)

###Android 绘图


[Android 绘图](https://www.zybuluo.com/dengzhirong/note/137761)