---
layout: post
title:  "PHP require and include Path"
categories: Server
---

    ##相对路径

```
./a/a.php (相对当前目录)    
../common.inc.php (相对上级目录)
```

    ##绝对路径（不用任何参考路径可唯一确定文件地址）

```
/apache/wwwroot/site/a/a.php
c:/wwwroot/site/a/a.php
```

    ##未确定路径

```
a/a.php  
common.inc.php
```

    ##require

```
A = http://[SITE]/app/test/a.php
```

    ###相对路径
相对路径需要一个参考目录才能确定文件的最终路径，在包含解析中，不管包含嵌套多少层，这个参考目录是程序执行入口文件所在目录。

    -   示例1
A  require './b/b.php';  //B=[SITE]/app/test/b/b.php
B  require './c.php';    //C=[SITE]/app/test/c.php 不是[SITE]/app/test/b/c.php

    -   示例2
A  require './b/b.php';  //B=[SITE]/app/test/b/b.php 
B  require '../c.php';   //C=[SITE]/app/c.php  不是 [SITE]/app/test/c.php

    -   示例3
A  require '../b.php';   //B=[SITE]/app/b.php 
B  require '../c.php';   //C=[SITE]/app/c.php  不是 [SITE]/c.php

    -   示例4
A  require '../b.php';   //B=[SITE]/app/b.php 
B  require './c/c.php';  //C=[SITE]/app/test/c/c.php  不是 [SITE]/app/c/c.php

    -   示例5
A  require '../inc/b.php';  //B=[SITE]/app/inc/b.php 
B  require './c/c.php';     //C=[SITE]/app/test/c/c.php 不是 [SITE]/app/inc/c/c.php

    -   示例6
A require '../inc/b.php';  //B=[SITE]/app/inc/b.php 
B require './c.php';       //C=[SITE]/app/test/c.php  不是 [SITE]/app/inc/c.php

    ###绝对路径
绝对路径的比较简单，不容易混淆出错，require|inclue 的就是对应磁盘中的文件。

    -   require '/wwwroot/xxx.com/app/test/b.php';    // Linux中
    -   require 'c:/wwwroot/xxx.com/app/test/b.php';  // windows中

dirname(__FILE__)计算出来的也是一个绝对路径形式的目录，但是要注意__FILE__是一个Magic constants，不管在什么时候都等于写这条语句的php文件所在的绝对路径，因此dirname(__FILE__)也总是指向写这条语句的php文件所在的绝对路径，跟这个文件是否被其他文件包含使用没有任何关系。

    -   示例1
A  require '../b.php';                  //B=[SITE]/app/b.php
B  require dirname(__FILE__).'/c.php';  //B=[SITE]/app/c.php
    
    - 示例2
A require '../inc/b.php';              // 则B=[SITE]/app/inc/b.php
B require dirname(__FILE__).'/c.php';  // 则B=[SITE]/app/inc/c.php 

始终跟B在同一个目录
结论：不管B是被A包含使用，还是直接被访问
B如果 require dirname(__FILE__).'/c.php';    // 则始终引用到跟B在同一个目录中的 c.php文件; 
B如果 require dirname(__FILE__).'/../c.php'; // 则始终引用到B文件所在目录的父目录中的 c.php文件; 
B如果 require dirname(__FILE__).'/c/c.php';  // 则始终引用到B文件所在目录的c子目录中的 c.php文件;

    ###未确定路径
首先在逐一用include_path中定义的包含目录来拼接[未确定路径]，找到存在的文件则包含成功退出，如果没有找到，则用执行require语句的php文件所在目录来拼接[未确定路径]组成的全路径去查找该文件，如果文件存在则包含成功退出，否则表示包含文件不存在，出错。 未确定路径比较容易搞混不建议使用。