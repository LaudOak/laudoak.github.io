---
layout: post
title: "Java Builder Pattern"
categories: Android
---

 >####将一个复杂的构建与其表示相分离，使得同样的构建过程可以创建不同的表示

 >建造模式是将复杂的内部创建封装在内部，对于外部调用的人来说，只需要传入建造者和建造工具，对于内部是如何建造成成品的，调用者无需关心。

 ![UML](resources/image/2015-9-1-builder_pattern.png)

 ```Java
 public interface Builder { 
　　　　void buildPartA(); 
　　　　void buildPartB(); 
　　　　void buildPartC(); 
　　
　　　　Product getResult(); 
　　} 

   //具体建造工具
　　public class ConcreteBuilder implements Builder { 
　　　　Part partA, partB, partC; 

　　　　public void buildPartA() {
　　　　　　//这里是具体如何构建partA的代码
　　　　}; 
　　　　public void buildPartB() { 
　　　　　　//这里是具体如何构建partB的代码
　　　　}; 
　　　　 public void buildPartC() { 
　　　　　　//这里是具体如何构建partB的代码
　　　　}; 
　　　　 public Product getResult() { 
　　　　　　//返回最后组装成品结果
　　　　}; 
　　}

   //建造者
　　public class Director {
　　　　private Builder builder; 
　　
　　　　public Director( Builder builder ) { 
　　　　　　this.builder = builder; 
　　　　} 
　　　　public void construct() { 
　　　　　　builder.buildPartA();
　　　　　　builder.buildPartB();
　　　　　　builder.buildPartC(); 
　　　　} 
　　} 


　　public interface Product { }
　　public interface Part { }


ConcreteBuilder builder = new ConcreteBuilder();
　　Director director = new Director( builder ); 
　　
　　director.construct(); 
　　Product product = builder.getResult();
 ```

 <br/>

 ```Java
 public class DoDoContact {
    private final int    age;
    private final int    safeID;
    private final String name;
    private final String address;
 
    public int getAge() {
        return age;
    }
 
    public int getSafeID() {
        return safeID;
    }
 
    public String getName() {
        return name;
    }
 
    public String getAddress() {
        return address;
    }
 
    public static class Builder {
        private int    age     = 0;
        private int    safeID  = 0;
        private String name    = null;
        private String address = null;

　　　// 构建的步骤
        public Builder(String name) {
            this.name = name;
        }
 
        public Builder age(int val) {
            age = val;
            return this;
        }
 
        public Builder safeID(int val) {
            safeID = val;
            return this;
        }
 
        public Builder address(String val) {
            address = val;
            return this;
        }
 
        public DoDoContact build() { // 构建，返回一个新对象
            return new DoDoContact(this);
        }
    }
 
    private DoDoContact(Builder b) {
        age = b.age;
        safeID = b.safeID;
        name = b.name;
        address = b.address;
 
    }
}


DoDoContact ddc = new DoDoContact.Builder("Ace").age(10)
                .address("beijing").build();
System.out.println("name=" + ddc.getName() + "age =" + ddc.getAge()
                + "address" + ddc.getAddress());
 ```