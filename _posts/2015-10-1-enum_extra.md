---
layout: post
title: Passing enum or object throgh Activity 
category: 云雀
---

### Reference

[Passing enum or object through an intent (the best solution)](http://stackoverflow.com/questions/2836256/passing-enum-or-object-through-an-intent-the-best-solution)

[Android: How to put an Enum in a Bundle?](http://stackoverflow.com/questions/3293020/android-how-to-put-an-enum-in-a-bundle)

### Realize
 - a

```Java
Given the following enum:

enum YourEnum {
  TYPE1,
  TYPE2
}
Bundle:

// put
bundle.putSerializable("key", YourEnum.TYPE1);

// get 
YourEnum yourenum = (YourEnum) bundle.get("key");
Intent:

// put
intent.putExtra("key", yourEnum);

// get
yourEnum = (YourEnum) intent.getSerializableExtra("key");
```

 - b

```Java
Given the following enum:

enum YourEnumType {
    ENUM_KEY_1, 
    ENUM_KEY_2
}
Put:

Bundle args = new Bundle();
args.putSerializable("arg", YourEnumType.ENUM_KEY_1);
```

