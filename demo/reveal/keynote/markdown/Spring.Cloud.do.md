# Spring Cloud 微服务实践
> 智慧医疗 - 杨建东

----

## 微服务

- 简单来说，服务化的核心就是将传统的一站式应用根据业务拆分成一个一个的服务，而微服务在这个基础上要更彻底地去耦合

----

## 为什么 Spring Cloud 更适应微服务架构

----

### 从使用 Nginx 说起

- 最初的服务化解决方案是给提供相同服务提供一个统一的域名，然后服务调用者向这个域名发送 HTTP 请求，由 Nginx 负责请求的分发和跳转

----

### 存在问题

- Nginx 作为中间层，在配置文件中耦合了服务调用的逻辑，这削弱了微服务的完整性，也使得 Nginx 在一定程度上变成了一个重量级的 ESB
- 服务的信息分散在各个系统，无法统一管理和维护。每一次的服务调用都是一次尝试，服务消费者并不知道有哪些实例在给他们提供服务
- 无法直观的看到服务提供者和服务消费者当前的运行状况和通信频率
- 消费者的失败重发，负载均衡等都没有统一策略，这加大了开发每个服务的难度，不利于快速演化

----

- 为了解决上面的问题，我们需要一个现成的中心组件对服务进行整合，将每个服务的信息汇总，包括服务的组件名称、地址、数量等
- 服务的调用方在请求某项服务时首先通过中心组件获取提供这项服务的实例的信息（IP、端口等），再通过默认或自定义的策略选择该服务的某一提供者直接进行访问

----

### Dubbo

- Dubbo 是阿里开源的一个 SOA 服务治理解决方案，文档丰富，在国内的使用度非常高

----

- 调用中间层变成了可选组件，消费者可以直接访问服务提供者
- 服务信息被集中到 Registry 中，形成了服务治理的中心组件
- 通过 Monitor 监控系统，可以直观地展示服务调用的统计信息
- Consumer 可以进行负载均衡、服务降级的选择

----

### 问题

- 只支持 RPC 调用。使得服务提供方与调用方在代码上产生了强依赖，服务提供者需要不断将包含公共代码的jar包打包出来供消费者使用
- 现在已经停止维护。目前 Github 社区上有一个 Dubbo 的升级版，叫 DubBox

----

### 新的选择 —— Spring Cloud

- 作为新一代的服务框架，Spring Cloud提出的口号是开发“面向云环境的应用程序”，它为微服务架构提供了更加全面的技术支持
- Spring Cloud抛弃了Dubbo的RPC通信，采用的是基于 HTTP 的 REST 方式
- 与Spring Framework、Spring Boot、Spring Data、Spring Batch等其他Spring项目完美融合，这些对于微服务而言是至关重要的
- 是一个正在持续维护的、社区更加火热的开源项目，这就保证使用它构建的系统，可以持续地得到开源力量的支持

----

## Spring Cloud 实践

- 主要通过整合 Netflix 的相关产品来实现这方面的功能，Spring Cloud Netflix

----

<img src="markdown/img/spring.cloud.do/spring.cloud.alt.png" style="background-color: white; width: 80%">

----

### 配置中心

- Spring Cloud Config，实现了配置集中管理、动态刷新的配置中心概念。配置通过 Git 或者简单文件来存储，支持加解密

----

### 服务治理

- 用于服务注册和发现的 Eureka(尤里卡)，调用断路器 Hystrix，调用端负载均衡 Ribbon(绿本)，Rest客户端 Feign

----

### 智能服务路由

- Zuul 的主要功能是路由转发
- 过滤，做一些安全验证

----

### 分布式链路监控

- Spring Cloud Sleuth 提供了全自动、可配置的数据埋点，以收集微服务调用链路上的性能数据，并发送给 Zipkin 进行存储、统计和展示

----

### 安全控制

- Spring Cloud Security 基于 OAuth2 这个开放网络的安全标准，提供了微服务环境下的单点登录、资源授权、令牌管理等功能。

----

### 消息组件

- Spring Cloud Stream 对于分布式消息的各种需求进行了抽象，包括发布订阅、分组消费、消息分片等功能，实现了微服务之间的异步通信
- Spring Cloud Stream 也集成了第三方的 RabbitMQ 和 Apache Kafka 作为消息队列的实现。而 Spring Cloud Bus 基于 Spring Cloud Stream，主要提供了服务间的事件通信（比如刷新配置）

----

### 实战项目

- [dev/sshapp-springcloud](http://58.216.212.154:10080/dev/sshapp-springcloud)

----

### 微服务调用

```
    @GetMapping("/consumer")
    public String dc() {
        ServiceInstance serviceInstance = loadBalancerClient.choose("eureka-client");
        String url = "http://" + serviceInstance.getHost() + ":" 
            + serviceInstance.getPort() + "/dc";

        log.info("消费服务 - {}", url);

        return restTemplate().getForObject(url, String.class);
    }
```

----

### 监控

- spring boot admin
- Prometheus & Grafana 可视化监控数据

----

### 发布

- 蓝绿部署：不停止老版本，额外搞一套新版本，等测试发现新版本OK后，删除老版本
- 滚动发布：按批次停止老版本实例，启动新版本实例
- 灰度发布/金丝雀部署：不停止老版本，额外搞一套新版本，常常按照用户设置路由权重，例如90%的用户维持使用老版本，10%的用户尝鲜新版本。不同版本应用共存，经常与A/B测试一起使用，用于测试选择多种方案。

----

## CAP 定理

- 在分布式系统领域有个著名的 CAP 定理：C——数据一致性，A——服务可用性，P——服务对网络分区故障的容错性。这三个特性在任何分布式系统中不能同时满足，最多同时满足两个。
- Spring Cloud Netflix 在设计 Eureka 时遵守的就是AP原则

----

## 参考

- [Spring-Cloud基础教程](http://blog.didispace.com/Spring-Cloud%E5%9F%BA%E7%A1%80%E6%95%99%E7%A8%8B/)
- [微服务架构——不是免费的午餐](https://blog.csdn.net/phodal/article/details/27098005)
- [微服务部署：蓝绿部署、滚动部署、灰度发布等部署方案对比与总结](http://www.itmuch.com/work/microservice-deploy/)
- 示例
    - [PiggyMetrics](https://github.com/sqshq/PiggyMetrics)

----

# 谢谢
