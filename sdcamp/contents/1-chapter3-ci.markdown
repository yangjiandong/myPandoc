# 持续集成 #

持续集成是一种软件开发实践，它是Martin Fowler先生提出[^31]的。它是一个在企业开发中必须的最基本的软件实践，谁也不会容忍企业的软件发布是在一台私人机器上完成的。

在持续集成中，团队成员频繁集成他们的工作成果，一般每人每天至少集成一次，在保证质量的同时也可以多次。每次集成会经过自动构建（包括自动测试）的验证，以尽快发现集成错误。许多团队发现这种方法可以显著减少集成引起的问题，并可以加快团队合作软件开发[^32]的速度。

在这一章中，我们先以一个简单的持续集成练习来体会一下，然后再来讨论企业中的持续集成和新动向。

## 环境准备 ##
服务器端准备好 Game of life项目的git仓库，客户端需要:

 * Maven 2.x 包 <http://maven.apache.org/download.html>
 * JDK 6 <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
 * Jenkins <http://jenkins-ci.org/>

## 持续集成流程 ##
持续集成的一个通常的简单流程如下：

 1. 将已集成的源代码复制一份到本地计算机。（`git clone/pull`)
 2. 修改产品代码和添加修改自动化测试。
 3. 把修改提交到源码仓库。(`git commit/git push`)
 4. 在持续集成服务器上基于主干（`master`）的代码再做一次构建（编译，单元测试，构建，打包）。
 5. 在持续集成服务器进行测试（验收）
 
如果上述所有操作没有任何错误，没有人工干预，并通过了所有测试，我们才可以认为这是一次成功的构建。

![持续集成流程](img/18333fig0301-tn.png)

## Maven ##
Maven是一个Java项目管理工具，就像Make对于c/c++项目。在Java的构建中和它“类似”的是Ant和Buildr。Maven比Ant的好处[^33]是：

 * 依赖包的管理只要写配置文件（`pom.xml`）就可以了，而Ant需要把第三方依赖的二进制包放在项目里。
 * 定义了标准集合，简单了项目的管理。

Maven主要还包括：

 * 一个项目对象模型 (Project Object Model)
 * 一组标准集合
 * 一个项目生命周期(Project Lifecycle)
 * 一个依赖管理系统(Dependency Management System)
 * 用来运行定义在生命周期阶段(phase)中插件(plugin)目标(goal)的逻辑。

### 安装Maven ###
装好JDK6，熟悉Unix环境，用Git bash安装Maven

    $ cd /c  # Windows C:/
    $ tar -zxvf ~/Desktop/apache-maven-2.2.1-bin.tar.gz
    $ mv apache-maven-2.2.1 maven
	
在系统中配好环境变量`M2`、`M2_HOME`、`MAVEN_OPTS`、`PATH`，如图3-2:

![系统中配好maven](img/18333fig0302-tn.png)

别忘了，需要重新打开bash后，配置才会起作用。

    $ mvn --version
    Apache Maven 2.2.1 (r801777; 2009-08-07 03:16:01+0800)

### Maven仓库管理器：Nexus ###
不管怎么样，Java的包在编译时还是要下载下来的，在企业中，最方便的是架设一个管理Java的包的服务器。其中最著名的就是Nexus，它会缓存远程仓库的Jar包。如图3-3 (源: http://today.java.net/article/2010/01/04/maven-repository-managers-enterprise)

![Maven仓库管理器](img/18333fig0303-tn.png)

对于个人来说，你不需要安装，只要在`~/.m2/settings.xml`配置指向企业使用的Nexus服务器就好了，如

```xml
# ~/.m2/settings.xml
<settings>
 <mirrors>
  <mirror>
    <id>nexus</id>
    <mirrorOf>*</mirrorOf>
    <url>http://localhost:8081/nexus/content/groups/public</url>
  </mirror>
 </mirrors>
</settings>
```
	
### 第一个maven命令 ###
在你的Game of life项目中，输入命令`mvn package`，观察命令行的输出，并且查看 `~/.m2/repository`目录的变化。

第一次执行还是比较慢的，大量的Jar包会下载到本地的缓存中，稍后会看见需要的依赖都在`~/.m2/repository`中了。

### 体会两层缓存 ###
实际上很容易理解，在个人机器上会有一个缓存，它在 `~/.m2/repository`，在Nexus服务器上是整个公司项目的缓存。

在你第二次编译时速度明显快了。

## 持续集成服务器：Jenkins ##
Jenkins是现在最流行也最有效的持续集成服务器，它的前身是著名的Hudson，后来由于Sun被Oracle收购以后，社区起了个新名字。

### 安装 ###
不需要安装，直接在命令行启动。

    $ java -jar ~/Desktop/jenkins.war --httpPort=7080

启动后就可以在你的浏览器中打开。<http://localhost:7080>，用7080端口只是为了防止可能的8080端口冲突。
	
### 安装Git插件 ###
Jenkins的强大得益于它的插件系统（以`.hpi`结尾），大部分情况下，你要的插件早在社区存在了。

为了使用Jenkins和Git服务器相连，你要安装Git插件。你可以选择从Jenkins系统中下载Git插件（如果公司有防火墙的话需要配Proxy），也可以直接把它下载到本地后，拷到`~/.jenkins/plugins`下，别忘了重启Jenkins服务器。这样你就能看到Git选项了。

### 系统配置Maven ###
在系统中配置好maven目录，别忘了把自动安装选项去掉。

![Jenkins 系统配置Maven](img/18333fig0304-tn.png)

### 设置构建任务 ###
新建一个任务`game-of-life`，选择自由风格（freestyle）。

  1. 源码管理：配置好Git的远端仓库。
  2. 构建触发器：设置轮询（`Poll`）策略：`*/1 * * * *` （每分钟一次）
  3. 构建：用`Invoke top-level maven targets`构建，填上`clean package`
  4. 构建后操作: `Archive the artifacts`选中后填上`**/target/*.jar,**/target/*.war`
  
![Jenkins game-of-life配置](img/18333fig0305-tn.png)

## 企业中的持续集成 ##


## 如何实施持续集成 ##
首要一步是把服务器架设起来，然后把你的脚本放在任务中自动执行。经常你会发现本地好好的，到了持续集成服务器就不对了。这是很常见的问题，基本上都是环境的影响。不管怎么样，要让团队明白，持续集成服务器构建出来的产品结果才是有效的。

其次持续集成是有团队负责的，要把结果透明化得显示在公共地方（如显示在电视上）。要养成集成失败后立马修复的好习惯，因为只要有一次没人修，慢慢的就没人用了。

![Jenkins监控显示屏](img/18333fig0306-tn.png)

此图来自[Extreme Feedback Panel插件](https://wiki.jenkins-ci.org/display/JENKINS/eXtreme+Feedback+Panel+Plugin)）。

最后要养成持续提高的工作态度，随着越来越多的东西加入持续集成，速度会变慢、经常出错。要不断的找到薄弱环节（bottleneck），查找相关技术来不断提高。

## 相关知识 ##
持续集成是十年前提出的东西，现在还有更多的好实践，建议看看持续交付一书。不仅产品代码需要持续集成，测试代码、基础设施的环境管理也需要持续集成。

在更多的持续集成上，要更进一步，达到持续交付。这并不一定代表你的产品一定需要在线运行，这更是一种软件开发的能力；你要很容易的部署到你的目标环境中，而且快速重现需要的配置。

## 课后练习 ##
 1. 装一些插件（Raditor，cobertura）体会一下。
 2. 把JUnit的单元测试结果显示出来。
 3. 查找构建输出在哪里。
 4. 和其他团队成员一起修改代码，并提交到代码库中，看看变化。
 
## 小结 ##
持续集成是敏捷软件开发的重中之重，一定要养成好的习惯。
 
## 参考阅读 ##
 * Jenkins: The Definitive Guide：<http://www.wakaleo.com/books/jenkins-the-definitive-guide>
 * Maven实战：<http://www.juvenxu.com/mvn-in-action/>
 * 持续集成软件质量改进和风险降低之道: <http://product.dangdang.com/product.aspx?product_id=20098017>
 * 持续集成理论和实践的新进展: <http://www.infoq.com/cn/articles/ci-theory-practice>
 * Repository Management with Nexus : <http://www.sonatype.com/books/nexus-book/reference/index.html>
 * 持续交付：<http://www.continuousdelivery.info/>
 
 [^31]: <http://martinfowler.com/articles/continuousIntegration.html>
 [^32]: <http://www.infoq.com/cn/articles/ci-theory-practice>
 [^33]: 所有的好处坏处都因人而异，请不要计较。

