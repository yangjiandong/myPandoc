# `Hibernate` 乐观锁，事务学习
> HRP 开发部 - 杨建东

----

# `Hibernate` 乐观锁

----

## 问题

- 当多个事务同时对数据库表中的同一条数据操作时，如果没有加锁机制的话，就会产生脏数据（duty data）。
- 有 2 种机制可以解决这个问题：乐观锁和悲观锁。这里我们只讨论乐观锁。

----

## 选择乐观锁

- 相对悲观锁而言，乐观锁机制采取了更加宽松的加锁机制。悲观锁大多数情况下依靠数据库的锁机制实现，以保证操作最大程度的独占性。但随之而来的就是数据库性能的大量开销，特别是对长事务而言，这样的开销往往无法承受。

----

## 实例说明

- 如一个金融系统，当某个操作员读取用户的数据，并在读出的用户数据的基础上进行修改时（如更改用户帐户余额），如果采用悲观锁机制，也就意味着整个操作过 程中（从操作员读出数据、开始修改直至提交修改结果的全过程，甚至还包括操作 员中途去煮咖啡的时间），数据库记录始终处于加锁状态，可以想见，如果面对几百上千个并发，这样的情况将导致怎样的后果。

----

## 乐观锁机制

- 乐观锁机制在一定程度上解决了这个问题。
- 乐观锁，大多是基于数据版本 （ Version ）记录机制实现。

----

## 数据版本

- 何谓数据版本？即为数据增加一个版本标识，在基于数据库表的版本解决方案中，一般是通过为数据库表增加一个 “version” 字段来实现。
- 读取出数据时，将此版本号一同读出，之后更新时，对此版本号加 1。
- 此时，将提交数据的版本数据与数据库表对应记录的当前版本信息进行比对，如果提交的数据版本号等于数据库表当前版本号，则予以更新，否则认为是过期数据。

----

## 实例场景重现

- 对于上面修改用户帐户信息的例子而言，假设数据库中帐户信息表中有一个 version 字段，当前值为 1 ；而当前帐户余额字段（ balance ）为 $100 。

----

- 操作员 A 此时将其读出（ version=1 ），并从其帐户余额中扣除 $50（ $100-$50 ）。

----

- 在操作员 A 操作的过程中，操作员 B 也读入此用户信息（ version=1 ），并从其帐户余额中扣除 $20 （ $100-$20 ）。

----

- 操作员 A 完成了修改工作，将数据版本号加 1（ version=2 ），连同帐户扣除后余额（ balance=$50 ），提交至数据库更新，此时由于提交数据版本等于数据库记录当前版本，数据被更新，数据库记录 version 更新为 2 。

```
update table set
version=?,
balance=?
where
id=?
and version=?
```

----

- 操作员 B 完成了操作，也将版本号加 1（ version=2 ）试图向数据库提交数据（ balance=$80 ），但此时比对数据库记录版本时发现，操作员 B 提交的数据版本号为 1 ，数据库记录当前版本也为 2 ，不满足 “ 提交版本必须等于记录当前版本才能执行更新 “ 的乐观锁策略，因此，操作员 B 的提交被驳回。

----

- 这样，就避免了操作员 B 用基于 version=1 的旧数据修改的结果覆盖操作员 A 的操作结果的可能。

----

- 相对悲观锁而言，乐观锁更倾向于开发运用！
- c/s 开发中 pb 默认采用该方式

----

## Hibernate 乐观锁是怎么做到的呢？
- 要实现 Hibenate 乐观锁，我们首先要在数据库表里增加一个版本控制字段，字段名随意，比如就叫`version`，对应 hibernate 类型只能为
	 - `long`,
	 - `integer`,
	 - `short`,
	 - `timestamp`,
	 - `calendar`，
	 - 也就是只能为数字或`timestamp`类型。


----

然后在 hibernate mapping 里作如下类似定义

```xml
<version name="version"
        column="VERSION"
        type="integer"/>
```

----

或者采用标注

```
@Version
public Integer getVersion() {
    return version;
}
```

----

- Hibernate 乐观锁，能自动检测多个事务对同一条数据进行的操作，并根据先胜原则，提交第一个事务，其他的事务提交时则抛出`org.hibernate.StaleObjectStateException`异常。

----

## 实例

- 培训项目 `sshapp-test`

```
test/java/org/ssh/pm/common/StudentServiceTest
testUpdateStudentByVersion
```

----

# 事务


----

## 手工事务

SessionFactory

- 单表操作

```
StudentServiceTest.testSaveStudentBySession
```

----

- 批处理

TODO 手工批处理，还有问题

```
StudentServiceTest.testBatchExecStudentByStudentDaoTx
```

----

## 标注

`@Transactional`

```
testSaveStudentByUseSession
```

----

## 异常

- 采用 @Transactional，保存完后，定义个异常，最终数据没有保存

```
StudentServiceExceptionTest.testSaveStudentException
```

----

- 手工事务，虽然触发异常但手工提交了数据就不回滚

```
testSaveStudentByUseSessionException
```

----

- 手工事务，触发异常数据回滚

```
testSaveStudentBySessionExceptionRollBack
```

----

# 练习

- 理解乐观锁的优势
- 考虑 version 使用场景
- 理解事务，提交回滚
- 项目练习

----

# 修改历史

- 2017.04.11 修改，基于 `version` 乐观锁更新数据，应该是提交记录 `version` 等于数据库后台 `version`，以前描述是 `提交数据 version 大于当前 version`

----

# 谢谢
