---
layout: post
title: Make all lines in an Edittext underline
categories: Android
---

###Reference:
[Android - How to make all lines in an edittext underlined?](http://stackoverflow.com/questions/10361755/android-how-to-make-all-lines-in-an-edittext-underlined)

[Android - edittext - underline](http://stackoverflow.com/questions/4114859/android-edittext-underline)


[Drawing multiple lines in edittext e.g. notepad](http://stackoverflow.com/questions/5972388/drawing-multiple-lines-in-edittext-e-g-notepad)

[EditText draw lines wrong](http://stackoverflow.com/questions/11529597/edittext-draw-lines-wrong)

![](/resources/image/getlinebounds.PNG)

![](/resources/image/edittext.PNG)

![](/resources/image/edittextlinespace.PNG)

###Using

```Java
 @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        int count = getLineCount();
        for (int i=0;i<count;i++)
        {
            int baseLine = getLineBounds(i,rect);
            canvas.drawLine(rect.left,baseLine+7,rect.right,baseLine+7,paint);
        }
    }
```


