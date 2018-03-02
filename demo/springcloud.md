% SpringCloud
% 杨建东
% 2018年02月24

# 微服务

Spring Cloud由众多子项目组成，如Spring Cloud Config、Spring Cloud Netflix、Spring Cloud Consul 等，提供了搭建分布式系统及微服务常用的工具，如配置管理、服务发现、断路器、智能路由、微代理、控制总线、一次性token、全局锁、选主、分布式会话和集群状态等，满足了构建微服务所需的所有解决方案。

- 比如使用Spring Cloud Config 可以实现统一配置中心，对配置进行统一管理
- 使用Spring Cloud Netflix 可以实现Netflix 组件的功能
- 服务发现（Eureka）、智能路由（Zuul）、客户端负载均衡（Ribbon）

# 与其他方案比较

## nginx

## dubbo

Dubbo基本不维护了。从框架的完整度来看，Dubbo只是实现了服务治理(注册 发现等)，而Spring Cloud下面有很多个子项目覆盖了微服务架构下的方方面面，服务治理只是其中的一个方面，一定程度来说，Dubbo只是Spring Cloud Netflix中的一个子集

参考

- [spring cloud在国内中小型公司能用起来吗？](https://www.zhihu.com/question/61403505)
- [知乎, 比较spring cloud和dubbo](https://www.zhihu.com/question/45413135)
- [网易考拉海购Dubbok框架优化详解](http://geek.csdn.net/news/detail/135152)
