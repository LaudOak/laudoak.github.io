---
layout: post
title: Custom your Appcompat AlertDialog style
categories: Android 
---

###Reference

[How to Use and Style the new AlertDialog from appCompat 22.1](http://stackoverflow.com/questions/29797134/how-to-use-and-style-the-new-alertdialog-from-appcompat-22-1)

```Java
AlertDialog.Builder builder = new AlertDialog.Builder(this, R.style.MyAlertDialogStyle);
builder.setTitle("AppCompatDialog");
builder.setMessage("Lorem ipsum dolor...");
builder.setPositiveButton("OK", null);
builder.setNegativeButton("Cancel", null);
builder.show();
```


```
<style name="MyAlertDialogStyle" parent="Theme.AppCompat.Light.Dialog.Alert">
    <!-- Used for the buttons -->
    <item name="colorAccent">#FFC107</item>
    <!-- Used for the title and text -->
    <item name="android:textColorPrimary">#FFFFFF</item>
    <!-- Used for the background -->
    <item name="android:background">#4CAF50</item>
</style>
```

![](/resources/image/alertstyle.png)