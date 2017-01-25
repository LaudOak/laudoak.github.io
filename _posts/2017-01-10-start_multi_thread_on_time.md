---
layout:  post
title: 使用CyclicBarrier同时启动多个线程
category: Java
---

reference:

[Class CyclicBarrier](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/CyclicBarrier.html)

[how-to-start-two-threads-at-exactly-the-same-time](http://stackoverflow.com/questions/3376586/how-to-start-two-threads-at-exactly-the-same-time)

### code

*BaseThread.java*

```java
public class BaseThread
{
    protected CyclicBarrier barrier;
    public BaseThread(CyclicBarrier barrier)
    {
        this.barrier = barrier;
    }
}
```

*Worker1*

```java
public class Worker1 extends BaseThread implements Runnable
{
    public Worker1(CyclicBarrier barrier)
    {
        super(barrier);
    }

    @Override
    public void run()
    {
        try
        {
            barrier.await();
        } catch (InterruptedException e)
        {
            e.printStackTrace();
        } catch (BrokenBarrierException e)
        {
            e.printStackTrace();
        }

        System.out.println("worker1:" + System.nanoTime());
    }
}

```

*Worker2*

```java
public class Worker2 extends BaseThread implements Runnable
{
    public Worker2(CyclicBarrier barrier)
    {
        super(barrier);
    }

    @Override
    public void run()
    {
        try
        {
            barrier.await();
        } catch (InterruptedException e)
        {
            e.printStackTrace();
        } catch (BrokenBarrierException e)
        {
            e.printStackTrace();
        }
        System.out.println("worker2:" + System.nanoTime());
    }
}

```

*Main.java*

```java
public class Main
{
    public static void main(String... args) throws BrokenBarrierException, InterruptedException
    {
        CyclicBarrier barrier = new CyclicBarrier(3);
        new Thread(new Worker1(barrier)).start();
        new Thread(new Worker2(barrier)).start();
        barrier.await();
        System.out.println("main:" + System.nanoTime());
    }
}

``` 

*result*

```
worker1:44030666278050
main:44030666490546
worker2:44030666278056
```

### CyclicBarrier类

CyclicBarrier类是一个允许一系列线程等待彼此到达一个公共屏障的同步辅助类,在数量固定的几个线程必须等待彼此同时启动的程序中很有用，称之为循环的是因为当等待的线程被释放后它可以重用；

