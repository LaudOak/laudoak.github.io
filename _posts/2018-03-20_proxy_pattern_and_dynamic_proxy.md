---
layout: post
title: Proxy Design Pattern & JDK Dynamic Proxy
category: Java
---

## Part 1 Proxy Pattern

**Reference**

[http://www.dcs.bbk.ac.uk/~oded/OODP13/Sessions/Session8/Proxy.pdf](http://www.dcs.bbk.ac.uk/~oded/OODP13/Sessions/Session8/Proxy.pdf)

[http://java-design-patterns.com/blog/controlling-access-with-proxy-pattern/](http://java-design-patterns.com/blog/controlling-access-with-proxy-pattern/)

**Types of Proxies**

1.Remote Proxy
2.Virtual Proxy
3.Copy-On-Write Proxy
4.Protection(Access)
5.Cache Proxy
6.Firewall Proxy
7.Synchronization Proxy
8.Smart Reference Proxy

`Protection proxy` limits access to the real subject. Based on some condition the proxy filters the calls and only some of them are let through to the real subject. 

`Virtual proxies` are used when an object is expensive to instantiate. In the implementation the proxy manages the lifetime of the real subject. It decides when the instance creation is needed and when it can be reused. Virtual proxies are used to optimize performance.

`Caching proxies` are used to cache expensive calls to the real subject. There are multiple caching strategies that the proxy can use. Some examples are read-through, write-through, cache-aside and time-based. The caching proxies are used for enhancing performance.

`Remote proxies` are used in distributed object communication. Invoking a local object method on the remote proxy causes execution on the remote object.

`Smart proxies` are used to implement reference counting and log calls to the object.

**Protection Proxy Sample**

In the example `WizardTower` is the interface for all the towers and `IvoryTower` implements it. The plain `IvoryTower` allows everyone to enter but the archwizard has specifically cast a protection spell on it to limit the number of simultaneous visitors. The protection spell enhanced `IvoryTower` is called `WizardTowerProxy`. It implements `WizardTower` and wraps `IvoryTower`. Now everyone wanting to access `IvoryTower` needs to go through the `WizardTowerProxy`.


_WizardTower_

```
public interface WizardTower {
    void enter(Wizard wizard);
}
```

_IvoryTower_

```
public class IvoryTower implements WizardTower {

    private static final Logger log = LoggerFactory.getLogger(IvoryTower.class);

    @Override
    public void enter(Wizard wizard) {
        log.info("{} enters the tower.", wizard);
    }
}

```

_WizardTowerProxy_

```
public class WizardTowerProxy implements WizardTower {
    private static final Logger log = LoggerFactory.getLogger(WizardTowerProxy.class);

    private static final int NUM_WIZARDS_ALLOWED = 3;

    private int numWizards;

    private final WizardTower tower;

    public WizardTowerProxy(WizardTower tower) {
        this.tower = tower;
    }


    @Override
    public void enter(Wizard wizard) {
        if (numWizards < NUM_WIZARDS_ALLOWED) {
            tower.enter(wizard);
            numWizards++;
        } else {
            log.info("{} is not allowed to enter!", wizard);
        }
    }
}

```

_PatternMain_

```
public class PatternMain {
    public static void main(String[] args) {
        WizardTowerProxy proxy = new WizardTowerProxy(new IvoryTower());
        proxy.enter(new Wizard("Red wizard"));
        proxy.enter(new Wizard("White wizard"));
        proxy.enter(new Wizard("Black wizard"));
        proxy.enter(new Wizard("Green wizard"));
        proxy.enter(new Wizard("Brown wizard"));
    }
}

```

_console_

```
2018-03-20 04:13:00:877 INFO  [main] IvoryTower:16 : Red wizard enters the tower.
2018-03-20 04:13:00:916 INFO  [main] IvoryTower:16 : White wizard enters the tower.
2018-03-20 04:13:00:917 INFO  [main] IvoryTower:16 : Black wizard enters the tower.
2018-03-20 04:13:00:917 INFO  [main] WizardTowerProxy:30 : Green wizard is not allowed to enter!
2018-03-20 04:13:00:918 INFO  [main] WizardTowerProxy:30 : Brown wizard is not allowed to enter!
```

**Copy-On-Write Proxy**

Reference:
[http://www.importnew.com/17576.html](http://www.importnew.com/17576.html)

1，写时复制容器，往新容器添加元素，写完后新容器引用赋给旧引用，读写分离思想

2，问题一：内存占用

3，问题二：不能保证数据实时一致性





