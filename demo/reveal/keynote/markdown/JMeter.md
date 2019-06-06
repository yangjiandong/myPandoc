# JMeter压力测试工具
> HRP 开发部 - 杨建东

----

## 测试指标

性能测试的主要概念和计算公式

----

## QPS

- Queries Per Second意思是“每秒查询率”，是一台服务器每秒能够相应的查询次数，是对一个特定的查询服务器在规定时间内所处理流量多少的衡量标准

----

## TPS

- TransactionsPerSecond的缩写，也就是事务数/秒。一个事务是指一个客户机向服务器发送请求然后服务器做出反应的过程

----

## 说明

- QPS（TPS）= 并发数/平均响应时间 或者 并发数 = QPS * 平均响应时间
- 这里响应时间的单位是秒
- 举例，我们一个HTTP请求的响应时间是20ms，在10个并发的情况下，QPS就是 QPS=10*1000/20=500

----

## JMeter 介绍

- Apache JMeter是100%纯JAVA桌面应用程序，用于测试客户端/服务端结构的软件(例如web应用程序)
- 用来测试静态和动态资源的性能，例如：web应用,数据库和FTP服务器等等
- 模拟大量负载来测试一台服务器，网络或者对象的健壮性或者分析不同负载下的整体性能   
- 对应用程序进行回归测试。通过你创建的测试脚本和assertions来验证你的程序返回了所期待的值

----

## 与LoadRunner比较

- 有着典型开源工具特点：界面不美观
- 结果分析能力没有LoadRunner详细
- 很它的优点也有很多

----

## 优点

- 开源
- 小巧，相比LR的庞大（最新LR11将近4GB），不需要安装，但需要JDK环境
- 支持多线程并发测试
- 完善的可视化测试结果
- 各种插件及自定义插件

----

## JMeter可以用来测试哪些

支持各种服务及协议类型

- Web - HTTP, HTTPS
- SOAP / REST
- FTP
- Database
- LDAP
- Message-oriented middleware (MOM)
- Mail
- TCP
- Native commands / shell scripts

----

## 缺点
　　
- 无法验证JS程序，
- 也无法验证页面UI
- 须和Selenium配合来完成Web2.0应用的测试

----

## 测试应用

- 集成测试
- 接口测试
- 压力测试
- 性能测试

----

## 测试目标

<img src=markdown/img/jmeter/PerformanceTesting.png>

----

- 静态资源访问的性能
- 找到服务能承受的最大并发访问量
- 形成性能测试报告

----

## 测试内容

<img src=markdown/img/jmeter/JMeterPerformanceTest.png>

----

## Load Testing

模拟多用户进行多并发访问

----

## Stress Testing

对关键业务做专门压力测试，找到服务的最大承受访问量

----

## 测试过程

<img src=markdown/img/jmeter/JMeterApacheSampler.png>


----

## 简单示例

访问`google.com` or `baidu.com`

----

## step1

- start JMeter
- Add -> Threads (Users) -> Thread Group

<img src=markdown/img/jmeter/JMeterAddThreadGroup.png>

----

设置测试属性

<img src=markdown/img/jmeter/ThreadGroupJMeterPerformance.png>

- Number of Threads: 100 , 模拟100个用户访问
- Loop Count: 10 , 每个用户访问10次
- Ramp-Up Period: 100, 停顿时间

----

Ramp-Up Period

- 设置JMeter 要在多长时间内建立全部的线程。默认值是0。如果未指定ramp-up period ，也就是说ramp-up period 为零， JMeter 将立即建立所有线程，假设ramp-up period 设置成T 秒， 全部线程数设置成N个， JMeter 将每隔<font color="orange">T/N</font>秒建立一个线程。 


<img src=markdown/img/jmeter/UserDelayHTTP.png>

----

- 如果要使用大量线程的话，ramp-up period 一般不要设置成零。 

    因为如果设置成零，Jmeter将会在测试的开始就建立全部线程并立即发送访问请求， 这样一来就很容易使服务器饱和，更重要的是会隐性地增加了负载，这就意味着服务器将可能过载，不是因为平均访问率高而是因为所有线程的第一次并发访问而引起的不正常的初始访问峰值，可以通过Jmeter的聚合报告监听器看到这种现象。 
    这种异常不是我们需要的，因此，确定一个合理的ramp-up period 的规则就是让初始点击率接近平均点击率。当然，也许需要运行一些测试来确定合理访问量。 

----

## step2

- Add -> Config Element -> HTTP Request Defaults.

<img src=markdown/img/jmeter/ThreadGroupAddJMeterPerformance.png>

<img src=markdown/img/jmeter/HTTPRequestJMeterPerformance.png>

----

## step3

- Add -> Listener -> Graph Results

<img src=markdown/img/jmeter/AddGrapgResultJMeter.png>


----

## step4

- Press Run button (Ctrl + R) 

<img src=markdown/img/jmeter/RunTestPlan.gif>

----

- Data(Black): 总共的样本数据, 或者说是发送给测试应用的请求总数
- Average(Blue): 请求响应时间的平均值
- Deviation(Red): 请求响应时间的标准差
- Throughput(Green): 吞吐量，每分钟服务端处理的请求数
- Median: 请求响应时间中值，即50%的请求响应时间

----

- Throughout

    吞吐量, 是衡量一个服务性能的重要指标，越高越好

- Deviation

    是衡量数据变化的指标，我的理解是服务性能的稳定性，越低越好

----

<img src=markdown/img/jmeter/738_888_d18.jpg>

----

## sshapp 项目测试

- session 问题
    - HTTP Cookie 管理器
    - HTTP URL 重写修饰符
    - JSESSIONID

----

## 准备工作

- 登录用户
- 对应线程数

----

<img src=markdown/img/jmeter/01.png>

----

<img src=markdown/img/jmeter/02.png>

----

<img src=markdown/img/jmeter/03.png>

----

<img src=markdown/img/jmeter/04.png>

----

<img src=markdown/img/jmeter/05.png>

----

## 自动测试，并形成报告

```
../bin/jmeter -n -t demo1.jmx -l result.jstl -e -o demoResultReport
```

----

## 报告详解

- 度量维度
    - APDEX(Application Performance Index)指数

----

- Over Time
    - Response Times Over Time: 响应时间
    - Bytes Throughput Over Time: 字节 接收/发送的数量
    - Latencies Over Time: 延迟时间

----

- Throughput
    - Hits Per Second: 每秒点击率
    - Codes Per Second: 每秒状态码数量
    - Transactions Per Second: 每秒事务量
    - Response Time Vs Request: 响应时间点请求的 成功/失败数
    - Latency Vs Request: 延迟时间点请求的 成功/失败数

----

- Response Times
    - Response Time Percentiles: 响应时间百分比
    - Active Threads Over Time: 激活线程数
    - Time Vs Threads: 测试过程中的线程数时续图
    - Response Time Distribution: 响应时间分布

----

[JMeter3.x性能报告说明](http://www.jianshu.com/p/be8930c4eef2)

----

## 日常开发中应用JMeter

- junit 程序员自己测试自己的代码
- JMeter 测试服务访问，性能

----

## 资料

- [JMeter 官方网站](http://jmeter.apache.org/)
- [教程](http://www.guru99.com/jmeter-performance-testing.html)
- [JMeter Tutorial gitbook](https://www.gitbook.com/book/aimer1124/jmeter-tutorial/details)

----

## 计算服务器数量

- QPS = req/sec = 请求数/秒
- 单台服务器每天PV计算
    - 公式1：每天总PV = `QPS * 60 * 60  * 6`
    - 公式2：每天总PV = `QPS * 60 * 60 * 8`
- 服务器计算服务器数量 = 每天总PV / 单台服务器每天总PV

----

## 峰值QPS和机器计算公式

- 原理：每天80%的访问集中在20%的时间里，这20%时间叫做峰值时间
- 公式：`( 总PV数 * 80% ) / ( 每天秒数 * 20% )` = 峰值时间每秒请求数(QPS)
- 机器：峰值时间每秒QPS / 单台机器的QPS   = 需要的机器

----

- 问：每天300w PV 的在单台机器上，这台机器需要多少QPS？

答：`( 3000000 * 0.8 ) / ( 24 * 60 * 60 * 0.2 ) = 139 (QPS)`

----

- 问：如果一台机器的QPS是58，需要几台机器来支持？

答：`139 / 58 = 3`

----
## 小测试

- 请完成一个10个线程组，5秒内挂起，执行2次的线程组配制

    - Number of Threads(users): 10
    - Ramp-Up Period(in seconds): 5
    - Loop Count: 2

- Throughput

----

# 谢谢