---
layout: post
title: Android TextView
categories: Android
---

### public int getLineBounds (int line, Rect bounds)

```
public int getLineBounds (int line, Rect bounds)

Added in API level 1
Return the baseline for the specified line (0...getLineCount() - 1) If bounds is not null, return the top, left, right, bottom extents of the specified line in it. If the internal Layout has not been built, return 0 and set bounds to (0, 0, 0, 0)

Parameters
line    which line to examine (0..getLineCount() - 1)
bounds  Optional. If not null, it returns the extent of the line
Returns
the Y-coordinate of the baseline
```

###public int getLineCount ()

```
public int getLineCount ()

Added in API level 1
Return the number of lines of text, or 0 if the internal Layout has not been built.
```


###public int getLineHeight ()

```
public int getLineHeight ()

Added in API level 1
Returns
the height of one `standard line` in pixels. Note that markup within the text can cause individual lines to be taller or shorter than this height, and the layout may contain additional first- or last-line padding.
```

###public int getMaxHeight ()

```
public int getMaxHeight ()

Added in API level 16
Related XML Attributes
android:maxHeight
Returns
the maximum height of this TextView expressed in pixels, or -1 if the maximum height was set in number of lines instead using or #setLines(int).
See Also
setMaxHeight(int)
```

###public int getMaxLines ()

```
public int getMaxLines ()

Added in API level 16
Related XML Attributes
android:maxLines
Returns
the maximum number of lines displayed in this TextView, or -1 if the maximum height was set in pixels instead using or #setHeight(int).
See Also
setMaxLines(int)
```

###public int getMaxWidth ()
```
public int getMaxWidth ()

Added in API level 16
Related XML Attributes
android:maxWidth
Returns
the maximum width of the TextView, in pixels or -1 if the maximum width was set in ems instead (using setMaxEms(int) or setEms(int)).
See Also
setMaxWidth(int)
setWidth(int)
```


###public int getMinHeight ()

```
public int getMinHeight ()

Added in API level 16
Related XML Attributes
android:minHeight
Returns
the minimum height of this TextView expressed in pixels, or -1 if the minimum height was set in number of lines instead using or #setLines(int).
See Also
setMinHeight(int)

```

###public int getMinLines ()

```
public int getMinLines ()

Added in API level 16
Related XML Attributes
android:minLines
Returns
the minimum number of lines displayed in this TextView, or -1 if the minimum height was set in pixels instead using or #setHeight(int).
See Also
setMinLines(int)
```

###public int getMinWidth ()

```
public int getMinWidth ()

Added in API level 16
Related XML Attributes
android:minWidth
Returns
the minimum width of the TextView, in pixels or -1 if the minimum width was set in ems instead (using setMinEms(int) or setEms(int)).
See Also
setMinWidth(int)
setWidth(int)
```
