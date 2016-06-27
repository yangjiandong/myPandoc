# 用Cucumber来实例化需求 #

在上一章中我们已经了解如何把需求用实例化的方式弄清楚，现在继续考虑怎么用通用的记录下来，并且去执行它。

这方面实际上有很多工具，在本章，我们会通过学习一种现在最有效的Cucumber软件来切身体会怎么将需求贯穿下去，其他的可以看相关知识。

开始前，再强调一下，滥用工具还不如不用，Cucumber也是如此。

## 环境准备 ##
 * Windows下的Ruby <http://rubyinstaller.org>
 
## Cucumber 简介 ##
Cucumber（英文：黄瓜）(官方网站是<http://cukes.info/>)是一个实例化需求的极佳实现伴侣。它是基于Ruby的开源测试工具，得益于Ruby便于创建和使用DSL的特性，它可以通过自然语言（文本文字）来描述需求（业务层），并通过关键字驱动和正则表达式匹配告诉去做哪些事情（驱动层），在运行自动化测试结束以后，还会给出详细的报告。


![Cucumber的架构](img/18333fig0601-tn.png)


下面就是一个加法例子的需求描述，Cucumber文件以`.feature`结尾。

```
# 加法 adding.feature
Feature: Adding
  In order to avoid silly mistakes
  As a math idiot
  I want to be told the sum of two numbers
  
  Scenario: Add two numbers
    Given the input "2+2"
    When the calculator is run
    Then the output should be "4"

  Scenario Outline: Add two numbers
    Given the input "<input>"
    When the calculator is run
    Then the output should be "<output>"
    Examples:
      | input | output |
      | 2+2 | 4 |
      | 98+1 | 99 |
```

这就是业务层，它和上一章最后的例子很像。功能标题后面是它的简要描述，然后是详细的例子。

建议好好读读Dan Nothy的文章：什么是故事<http://dannorth.net/whats-in-a-story/>。

现在让我们试着来运行它，看看会怎么样。

## 安装 ##
在Windows上，RubyInstaller提供了ruby的环境，下载安装包（如`rubyinstaller-1.9.3-p0.exe`)，运行即可，别忘了把“Ruby放入PATH中”的选项选上。

![Windows平台安装Cucumber](img/18333fig0602-tn.png)

  $ gem install cucumber # 如果需要配代理，-p http://<proxyserver>:<port>
  $ gem install rspec # cucumber 需要
    
## 运行Cucumber ##

一旦Cucumber装好了，我们就可以使用 cucumber 命令来运行feature文件。

feature文件放在`features`目录下，如果cucumber命令后不跟任何东西的话，那么它会执行所有的.feature文件。如果我们只想运行某一个.feature文件，我们可以使用命令 `cucumber features\feature_name`

  $ cucumber features/adding.feature
  Feature: Adding
    In order to avoid silly mistakes
    As a math idiot
    I want to be told the sum of two numbers

    Scenario: Add two numbers       # features\adding.feature:3
      Given the input "2+2"         # features\adding.feature:4
      When the calculator is run    # features\adding.feature:5
      Then the output should be "4" # features\adding.feature:6

    Scenario Outline: Add two numbers      # features\adding.feature:8
      Given the input "<input>"            # features\adding.feature:9
      When the calculator is run           # features\adding.feature:10
      Then the output should be "<output>" # features\adding.feature:11

      Examples:
        | input | output |
        | 2+2   | 4      |
        | 98+1  | 99     |

  3 scenarios (3 undefined)
  9 steps (9 undefined)
  0m0.046s

  You can implement step definitions for undefined steps with these snippets:

  Given /^the input "([^"]*)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
  end
  ...

你就可以看到它被正常执行了，发现了3个场景（scenarios），9个步骤（steps），这不就是我们需要的测试吗！！

让我们来解读一下吧。

## 业务层：Gherkin语言 ##

业务层实际使用的是[Gherkin语言](gherkin)，Cucumber是一个解释程序，它用来执行解释 .feature文件里业务描述，它的关键字就是“Given”、“And”等等这样的字眼。

一个常见的Cucumber文件描述分为 **Feature（特性）**、**Scenario（场景）**、和**Step（步骤）**。让我们再来看看上面的例子:

 1. `Feature: Adding`: 这是标题，每一个feature文件以关键字**Feature**开始，且紧跟着一个冒号和一个简单描述。
 2. 在上面，你发现接下来的几行描述不会被解析，纯粹是描述用的（当然也很重要），强烈建议你照**用户故事（User Story）**的方式去写。
 3. `Scenario: Add two numbers`：关键字_Scenario_后面紧跟一个冒号和一个对应该场景的描述，也是简短的一句话。
 5. 后面的以**Given/When/Then/And/But**开头（这些也是关键字）的都是步骤（步骤后面不需要跟冒号），用来阐述到底要的是什么样的需求。
 6. `Scenario Outline: Add two numbers`: 关键字Scenario Outline，和Scenario不同的是它是支持表格的形式。
 7. **Scenario** 和 **Scenario Outline**提供了特性的多个场景，可以出现多次。**Scenario Outline**提供了表格的形式，适合批量数据的处理。
 
具体怎么连到被测系统就靠驱动层了。
 
## 驱动层 ##
驱动层的主要目的就是把业务层中的数据（如上“2+2”，“加”）提取出来，通过于应用程序进行交互，最后把返回结果和预期的值（“4”）进行比对，得出测试结果。

Cucumber的驱动层可以用Ruby，Java和其他语言来支持，很多时候语言的选择主要依赖团队的兴趣。这里以Ruby为例，当然不用担心，因为介绍的例子不需要很多深奥的知识。

在Cucumber中，第一次运行后，它会给出Ruby代码的模板，就是：

  Given /^the input "([^"]*)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
  end
  ...

如果对脚本或Linux比较了解的话，很容易看出，这是一个正则表达式。

在`features`下面建一个`step_definitions`目录，把上面运行的代码模板片段写入`calculator_steps.rb`文件中，并且把`pending`那一行用`#`注释掉，再次运行`cucumber`，就很顺利通过了。

  3 scenarios (3 passed)
  9 steps (9 passed)

真实情况下，我们要写些代码匹配到关键字处理后，想办法传递到被测的系统，并和设定的期望值匹配来确定测试结果。

## 常用的目录结构 ##
常用的目录结构组织方式是

```bash
$ find calculator
calculator/
calculator/feature.html
calculator/features
calculator/features/adding.feature
calculator/features/division.feature
calculator/step_definitions
calculator/step_definitions/calculator_steps.rb
```

 1. `features`下面按功能放置各个业务。
 2. `step_definitions`存放驱动层的脚本。
 
## 继续网上书店的例子 ## 
Cucumber虽然上是支持多语言包括中文[^61]的，但还是建议关键字用英文来写，以免其他工具的不支持。

用Cucumber重写的话，下面是一种方案。

  # book.feature
  Feature: 买书免运费
    提供读者(不管普通还是VIP客户）买书优惠活动，
    买书超过（含）6本以上的，可以免费送货到除西藏省，青海省的大陆地区。
    Scenario Outline: 
      Given 一个客户买了 <几本书>
      And 买了 <其他类别> 的东西
      When 选好 <送货地址>
      Then 看见 <运费为0>
      
      Examples:
      | 几本书| 其他类别 | 送货地址 | 运费为0 |
      |  6    | n/a      | 上海     |  yes    |
      |  6    | n/a      | 西藏     |  no     |
      |  5    | n/a      | 上海     |  no     |
      |  6    |          | 上海     |  no     |

它对应的用Ruby实现的驱动层的代码就可以类似：

```ruby
  def onlinebookstore(book_number,other_order_category,delivery_address)
  	# 写代码发往被测系统，得到运费
      return 10 #模拟运费10元
  end
  Given /^一个客户买了 (\d+)$/ do |number|
    @book_number = number
  end
  Given /^买了(.*) 的东西$/ do |category|
    @order_category = category
  end
  When /^选好 (.*)$/ do |address|
    @delivery_address = address
    @result = onlinebookstore(@book_number, @order_category,@delivery_address)
  end
  Then /^看见 (yes|no)$/ do |expected_output|
    if(expected_output == 'yes')
      @result.should == 0
    else
      @result.should == 1
    end
  end    
```
所以运行后，你应该能够从输出结果中看到3个Scenario测试通过了。

  4 scenarios (1 failed, 3 passed)
  16 steps (1 failed, 15 passed)
  0m0.076s

如果你上过TDD了，就知道现在我演示的只是模拟的实现，现在就是驱动你把驱动层的代码写好使他被运行通过。

怎么样，有点感觉了，多多练习吧。

## 常见问题 ##

### 我们的系统没有接口能够被这么（或容易）测试得？ ###

好问题！！上面这个网上书店系统

 * 可能使用Flash写的，你根本没法用脚本填充数据，然后得到结果。
 * 或者就算是用HTML5写的，但是调用它也是很费时间周折的呀。

是的，没错测试是费时的，但再想想背后的原因！

这就是没有测试驱动开发的后果，任何技术的设计不仅要考虑实现，也要考虑测试，**应用程序是否能够被自动化测试**是一个衡量软件开发水平的重要标志。否者要架构师干嘛？

### Cucumber用起来了，也自动化了，但是没人看？ ###
正常。不要为了Cucumber而Cucumber；不要为了自动化而自动化。

首先要理解实例化需求，然后再用工具去支持，不能本末倒置。

另外把结果变成网页或者贴在墙上都是不错的建议，试试下面的命令吧？

  $ cucumber --format progress --format html --out=features_report.html

看看HTML的输出，你也可以自己定制你的报告。

![Cucumber的架构](img/18333fig0603-tn.png)

## 相关知识 ##
 * [FitNesse](http://fitnesse.org/)也是ATDD中很著名的一种工具，在Cucumber前占有很大的地位。
 * [敏捷测试的思考和新发展](http://blog.csdn.net/kerryzhu/article/details/6752992)

## 课后练习 ##
 1. 把网上书店的例子，尝试用实例化需求说明的方式来描述清楚，并写成Cucumber的格式。
 2. 阅读参考书，了解更多的Cucumber知识。
 2. 了解Gherkin语言的详细内容，如**tag**，并结合Cucumber去执行。
 3. 看看如何能够实施Cucumber，使它能够整合到持续集成中去。
 
## 小结 ##

Cucumber也只是一种工具，如果不理解实例化需求说明的真正意义，它会被用得很累，好自为之。

## 参考阅读 ##
 1. Book: Specification by example. <http://manning.com/adzic>
 2. Specification by example <http://specificationbyexample.com>
 3. Cucumber <http://cukes.info>
 4. Gherkin语言：<https://github.com/cucumber/cucumber/wiki/Gherkin>
 5. Book: The Secret Ninja Cucumber Scrolls: <http://cuke4ninja.com/>
 
 [gherkin]: https://github.com/cucumber/cucumber/wiki/Gherkin 

