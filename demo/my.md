
>Spring Boot是由Pivotal团队提供的全新框架，其设计目的是用来简化新Spring应用的初始搭建以及开发过程。该框架使用了特定的方式来进行配置，从而使开发人员不再需要定义样板化的配置。通过这种方式，Boot致力于在蓬勃发展的快速应用开发领域（rapid application development）成为领导者。

多年以来，Spring IO平台饱受非议的一点就是大量的XML配置以及复杂的依赖管理。在去年的SpringOne 2GX会议上，Pivotal的CTO Adrian Colyer回应了这些批评，并且特别提到该平台将来的目标之一就是实现免XML配置的开发体验。Boot所实现的功能超出了这个任务的描述，开发人员不仅不再需要编写XML，而且在一些场景中甚至不需要编写繁琐的import语句。在对外公开的beta版本刚刚发布之时，Boot描述了如何使用该框架在140个字符内实现可运行的web应用，从而获得了极大的关注度，该样例发表在tweet上。

然而，Spring Boot并不是要成为Spring IO平台里面众多“Foundation”层项目的替代者。Spring Boot的目标不在于为已解决的问题域提供新的解决方案，而是为平台带来另一种开发体验，从而简化对这些已有技术的使用。对于已经熟悉Spring生态系统的开发人员来说，Boot是一个很理想的选择，不过对于采用Spring技术的新人来说，Boot提供一种更简洁的方式来使用这些技术。

在追求开发体验的提升方面，Spring Boot，甚至可以说整个Spring生态系统都使用到了Groovy编程语言。Boot所提供的众多便捷功能，都是借助于Groovy强大的MetaObject协议、可插拔的AST转换过程以及内置的依赖解决方案引擎所实现的。在其核心的编译模型之中，Boot使用Groovy来构建工程文件，所以它可以使用通用的导入和样板方法（如类的main方法）对类所生成的字节码进行装饰（decorate）。这样使用Boot编写的应用就能保持非常简洁，却依然可以提供众多的功能。

# 安装Boot

从最根本上来讲，Spring Boot就是一些库的集合，它能够被任意项目的构建系统所使用。简便起见，该框架也提供了命令行界面，它可以用来运行和测试Boot应用。框架的发布版本，包括集成的CLI（命令行界面），可以在Spring仓库中手动下载和安装。一种更为简便的方式是使用Groovy环境管理器（Groovy enVironment Manager，GVM），它会处理Boot版本的安装和管理。Boot及其CLI可以通过GVM的命令行gvm install springboot进行安装。在OS X上安装Boot可以使用Homebrew包管理器。为了完成安装，首先要使用brew tap pivotal/tap切换到Pivotal仓库中，然后执行brew install springboot命令。

要进行打包和分发的工程会依赖于像Maven或Gradle这样的构建系统。为了简化依赖图，Boot的功能是模块化的，通过导入Boot所谓的“starter”模块，可以将许多的依赖添加到工程之中。为了更容易地管理依赖版本和使用默认配置，框架提供了一个parent POM，工程可以继承它。Spring Boot工程的样例POM文件定义如程序清单1所示。

程序清单1

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>myproject</artifactId>
    <version>1.0.0-SNAPSHOT</version>

    <!-- Inherit defaults from Spring Boot -->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>1.0.0.RC1</version>
    </parent>

    <!-- Add typical dependencies for a web application -->
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
    </dependencies>

    <repositories>
        <repository>
            <id>spring-snapshots</id>
            <url>http://repo.spring.io/libs-snapshot</url>
        </repository>
    </repositories>

    <pluginRepositories>
        <pluginRepository>
            <id>spring-snapshots</id>
            <url>http://repo.spring.io/libs-snapshot</url>
        </pluginRepository>
    </pluginRepositories>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

为了实现更为简单的构建配置，开发人员可以使用Gradle构建系统中简洁的Groovy DSL，如程序清单1.1所示。

程序清单1.1

```
buildscript {
  repositories {
    maven { url "http://repo.spring.io/libs-snapshot" }
    mavenCentral()
  }
  dependencies {
    classpath("org.springframework.boot:spring-boot-gradle-plugin:1.0.0.RC1")
  }
}

apply plugin: 'java'
apply plugin: 'spring-boot'

repositories {
  mavenCentral()
  maven { url "http://repo.spring.io/libs-snapshot"  }
}

dependencies {
  compile 'org.springframework.boot:spring-boot-starter-actuator:1.0.0.RC1'
}
```

为了快速地搭建和运行Boot工程，Pivotal提供了称之为“Spring Initializr” 的web界面，用于下载预先定义好的Maven或Gradle构建配置。我们也可以使用Lazybones模板实现快速起步，在执行lazybones create spring-boot-actuator my-app命令后，它会为Boot应用创建必要的工程结构以及gradle构建文件。

# 开发Spring Boot应用

Spring Boot[^1] 在刚刚公开宣布之后就将一个样例发布到了Twitter上，它目前成为了最流行的一个应用样例。它的全部描述如程序清单1.2所示，一个非常简单的Groovy文件可以生成功能强大的以Spring为后端的web应用。

这个应用可以通过spring run App.groovy命令在Spring Boot CLI[^2] 中运行。Boot会分析文件并根据各种“编译器自动配置（compiler auto-configuration）”标示符来确定其意图是生成Web应用。然后，它会在一个嵌入式的Tomcat中启动Spring应用上下文，并且使用默认的8080端口。打开浏览器并导航到给定的URL，随后将会加载一个页面并展现简单的文本响应：“hello”。提供默认应用上下文以及嵌入式容器的[^3] 这些过程，能够让开发人员更加关注于开发应用以及业务逻辑，从而不用再关心繁琐的样板式配置。

Boot能够自动确定类所需的功能，这一点使其成为了强大的快速应用开发工具。当应用在Boot CLI中执行时，它们在使用内部的Groovy编译器进行构建，这个编译器可以在字节码生成的时候以编码的方式探查并修改类。通过这种方式，使用CLI的开发人员不仅可以省去定义默认配置，在一定程度上甚至可以不用定义特定的导入语句，它们可以在编译的过程中识别出来并自动进行添加。除此之外，当应用在CLI中运行时，Groovy内置的依赖管理器，“Grape”，将会解析编译期和运行时的类路径依赖，与Boot编译器的自动配置机制类似。这种方式不仅使得框架更加对用户友好，而且能够让不同版本的Spring Boot与特定版本的来自于Spring IO平台的库相匹配，这样一来开发人员就不用关心如何管理复杂的依赖图和版本结构了。另外，它还有助于快速原型的开发并生成概念原型的工程代码。

对于不是使用CLI构建的工程，Boot提供了许多的“starter”模块，它们定义了一组依赖[^4] ，这些依赖能够添加到构建系统之中，从而解析框架及其父平台所需的特定类库。例如，spring-boot-starter-actuator依赖会引入一组基本的Spring项目，从而实现应用的快速配置和即时可用。关于这种依赖，值得强调的一点就是当开发Web应用，尤其是RESTful Web服务的时候，如果包含了spring-boot-starter-web依赖，它就会为你提供启动嵌入式Tomcat容器的自动化配置，并且提供对微服务应用有价值的端点信息，如服务器信息、应用指标（metrics）以及环境详情。除此之外，如果引入spring-boot-starter-security模块的话，actuator会自动配置Spring Security，从而为应用提供基本的认证以及其他高级的安全特性。它还会为应用结构引入一个内部的审计框架，这个框架可以用来生成报告或其他的用途，比如开发认证失败的锁定策略。

[^1]: On their friendship, [see @Campbell_1987 p. 314-318; @Duckworth_1956 p. 281-316]; that the two were not friends by the time of the *Odes*, [see @Thomas_2001 p. 60] who argues that Horace and Vergil were only acquaintances and [@Moritz_1969 p. 13] who believes that the friendship was strained by the publication of the *Odes*. For a response to such readings, see Margheim 2012.

[^2]: Horace’s poetry provides the sole basis for positing a friendship. Vergil never mentions Horace by name in his poetry, and no other contemporary or near-contemporary sources ascribe *amicitia* to the two poets, although by 380 St. Jerome assumes a friendship. Horace names Vergil ten times throughout his corpus (*Sat*. 1.5.40, 48, 1.6.55, 1.10.45, 81; *Odes* 1.3.6, 1.24.10, 4.12.13; *Ep*. 2.1.247; *A.P*. 55), five times in the *Satires* alone, where Vergil consistently appears as a friend and colleague. 

[^3]: Though there is some debate whether the Vergilius of 4.12 is Virgil the poet, the *opinio communis* today asserts this identification (see below, p. 10).

[^4]: For readings of *Odes* 1.24, [see @Commager_1995 p. 287-90; @Khan_1967; @Nisbet-Hubbard_1970 p. 279-89; @Lowrie_1994 p. 377-94; @Putnam_1992; @Horace_1995 p. 112-15]. For the Epicurean, and specifically Philodeman, influence on the ode, [@Thibodeau_2003 pp. 243-56, and @Armstrong_2008 p. 97-99].

# 延伸阅读

Spring Boot团队已经编写了完整的指导和样例来阐述框架的功能。Blog文章、参考资料以及API文档都可以在Spring.IO网站上找到。项目的GitHub页面上可以找到示例的工程，更为具体的细节可以阅读Spring Boot的参考手册。SpringSourceDev YouTube频道有一个关于Spring Boot的webinar，它概述了这个项目的目标和功能。在去年在伦敦举行的Groovy & Grails Exchange上，David Dawson做了一个使用Spring Boot开发微服务的演讲。

# 关于作者

Daniel Woods是Netflix的高级软件工程师，负责开发持续交付和云部署工具。他擅长JVM栈相关的技术，活跃在Groovy、Grails和Spring社区。可以通过电子邮件地址danielpwoods@gmail.com或Twitter @danveloper联系到Daniel。
