---
layout: post
title: "Android Custom View"
categories: Android
---

##LayoutInflater
 - ####获取LayoutInflater实例

    ```Java
    LayoutInflater layoutInflater = LayoutInflater.from(context);

    LayoutInflater layoutInflater = (LayoutInflater) context
        .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

    ```
 - ####使用LayoutInflater实例加载布局

    layoutInflater.inflate(resourceId, root);

    public View inflate(XmlPullParser parser, ViewGroup root, boolean attachToRoot) {
        synchronized (mConstructorArgs) {
            final AttributeSet attrs = Xml.asAttributeSet(parser);
            mConstructorArgs[0] = mContext;
            View result = root;
            try {
                int type;
                while ((type = parser.next()) != XmlPullParser.START_TAG &&
                        type != XmlPullParser.END_DOCUMENT) {
                }
                if (type != XmlPullParser.START_TAG) {
                    throw new InflateException(parser.getPositionDescription()
                            + ": No start tag found!");
                }
                final String name = parser.getName();
                if (TAG_MERGE.equals(name)) {
                    if (root == null || !attachToRoot) {
                        throw new InflateException("merge can be used only with a valid "
                                + "ViewGroup root and attachToRoot=true");
                    }
                    rInflate(parser, root, attrs);
                } else {
                    /*
                    createViewFromTag()方法，节点名和参数传进去。它根据节点名来创建View对象。在createViewFromTag()方法的内部又会去调用createView()方法，然后使用反射的方式创建出View的实例并返回。
                    */
                    View temp = createViewFromTag(name, attrs);
                    ViewGroup.LayoutParams params = null;
                    if (root != null) {
                        params = root.generateLayoutParams(attrs);
                        if (!attachToRoot) {
                            temp.setLayoutParams(params);
                        }
                    }

                    /*
                    循环遍历根布局下的子元素,每次递归完成后则将这个View添加到父布局当中
                    */
                    rInflate(parser, temp, attrs);
                    if (root != null && attachToRoot) {
                        root.addView(temp, params);
                    }
                    if (root == null || !attachToRoot) {
                        result = temp;
                    }
                }
            } catch (XmlPullParserException e) {
                InflateException ex = new InflateException(e.getMessage());
                ex.initCause(e);
                throw ex;
            } catch (IOException e) {
                InflateException ex = new InflateException(
                        parser.getPositionDescription()
                        + ": " + e.getMessage());
                ex.initCause(e);
                throw ex;
            }
            return result;
        }
    }

 - ####layout_width和layout_height

 layout_width和layout_height用于设置View**在布局中**的大小，也就是说，首先View必须存在于一个布局中。