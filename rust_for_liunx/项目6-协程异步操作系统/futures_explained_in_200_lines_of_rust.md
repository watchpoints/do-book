---
title: "Rust For Linux"
date: 2023-11-06
description: ""
draft: false
tags: ["book"]
---





https://stevenbai.top/rust/futures_explained_in_200_lines_of_rust/



## 如何学习

> 在本文中，我将试着去回答liunx 内核参数：
> Q1 (Why): 为什么需要协程？
> 我们会一起回顾协程出现的历史背景，当时要解决什么问题；同时，现在是什么场景，需要使用协程来进行处理？为什么进程或者线程不能够很好地满足当下的使用场景？
> Q2 (What): 到底什么是协程？
> 我们一直在谈论协程。由于协程中包含有「程」这个字眼，因此经常被拿来与进程线程进行对比，称协程为「用户态线程」；但又有人从协程实现的角度，说「协程是一种泛化的函数」。这就把我们给绕晕了。我们不禁要问，到底什么是协程？在本次分享中，我会试着进行回答。
> Q3 (How): 怎么实现协程 (库)？
> 在回答了协程是什么之后，第三个问题就紧随而来，我们可以自己去实现一个简单的协程或者协程库吗？如果可以实现，那我们应该怎么实现呢？
> Q4 (Usage): 使用协程时需要注意什么？
> 通过实际编码实现一个简单的协程库后，我们再来看 libco 的实现，就会清晰明了。我们会在第四部分介绍使用协程时需要注意的一些问题。
> 这就是我本次分享想要达成的目标 —— 回答这四个问题。

~~~
 一、这个技术出现的背景、初衷和要达到什么样的目标或是要解决什么样的问题 

 二、这个技术的优势和劣势分别是什么 

三、这个技术适用的场景。任何技术都有其适用的场景，离开了这个场景

四、技术的组成部分和关键点。

五、技术的底层原理和关键实现

六、已有的实现和它之间的对比
~~~







# 2023-01-06



录制: 第三阶段项目方向选题会
日期: 2023-11-05 19:58:18
录制文件：https://meeting.tencent.com/v2/cloud-record/share?id=54cbe9a8-fa09-4ac4-82ce-5888129808e7&from=3

https://shimo.im/docs/m8AZM4Z6X9tzG7kb


相关资料
训练营第三阶段项目实习选题会ppt介绍（这里的幻灯片中的链接无法访问。）
训练营第三阶段项目方向选题会“项目六：基于协程异步机制的操作系统/驱动”介绍（这里的幻灯片中的链接是可以访问的。）

选题协商
请各位同学在这里填写自己的选题意向，以便大家相互了解进展并进行可能的合作。
任务一要求所有同学参与，后面的六个任务可以选择自己有兴趣的部分参与，可以多人合作。

任务一：Embassy文档翻译
Embassy Documentation：Embassy is a project to make async/await a first-class option for embedded development.
具体任务描述：
看教学视频：并发与处理器、操作系统和编程语言
学习“协程的实现(200行代码讲透RUST FUTURES)”，写学习笔记；
填写自己想翻译的“Embassy Documentation”章节。
把翻译结果上传到公开仓库，并提交访问链接；

任务二：开发和移植跨OS的异步驱动
具体任务描述：
学习“Async Rust vs RTOS showdown（中文版本）”，写学习笔记；
在qemu模拟的RISC-V平台，尝试移植
任务三：异步机制的硬件支持 - 用户态中断的QEMU和FPGA实现和改进
任务四：共享调度器
任务五：reL4微内枋操作系统的异步改进
任务六：异步内核模块
任务七：异步函数调用栈跟踪分析





## 任务一：Embassy文档翻译

### 看教学视频：[并发与处理器、操作系统和编程语言](https://www.xuetangx.com/learn/THU0809100czxt/THU0809100czxt/14294493/video/25500376)





### 200行代码讲透RUST FUTURES



目的：这个技术出现的背景、初衷和要达到什么样的目标或是要解决什么样的问题 

探索释Rust中的Futures， 为什么他们被设计成这样，以及他们如何工作。



阅读资料：

 Rust 中写的关于并发编程的第四文章

- https://stevenbai.top/rust/futures_explained_in_200_lines_of_rust/
- https://cfsamson.github.io/book-exploring-async-basics/
- https://cfsamson.gitbook.io/green-threads-explained-in-200-lines-of-rust/
- https://cfsamsonbooks.gitbook.io/epoll-kqueue-iocp-explained/



线程为不写并发使用的

语法：thread::spawn 与spawn闭包

参数传递方式：同C++11 Lambda的变量捕获



## 三 Rust中的Futures

### 概述

1. Rust中并发性的高级介绍
2. 了解 Rust 在使用异步代码时能提供什么，不能提供什么
3. 了解为什么我们需要 Rust 的运行时库
4. 理解“leaf-future”和“non-leaf-future”的区别
5. 了解如何处理 CPU 密集型任务







> 注解：
>
> 什么是`Future`? `Future`是一些将在未来完成的操作。 Rust中的异步实现基于轮询,每个异步任务分成三个阶
>
> 1. 轮询阶段 执行器(executor
> 2. 等待阶段. 事件源(通常称为reactor)注册等待一个事件发生
> 3. . 唤醒阶段

回顾：IO模型

- 面试经典题目：IO多路复用——深入浅出理解select、poll、epoll

- 面试经典题目：高级IO模型之kqueue和epoll

五种IO模型

《*UNIX网络编程*》(第1卷)(套接口API第3版)第1版和第2络专家W. Richard Stevens博士独自编写。

```text
[1]blockingIO - 阻塞IO
[2]nonblockingIO - 非阻塞IO
[3]signaldrivenIO - 信号驱动IO
[4]asynchronousIO - 异步IO
[5]IOmultiplexing - IO多路复用
```

多路服用 事件完成通知 事件就绪通知

面试经典题目：高级IO模型之kqueue和epol

kqueue 不仅能够处理文件描述符事件，还可以用于各种其他通知，例如文件修改监视、信号、异步 I/O 事件 (AIO)、子进程状态更改监视和支持纳秒级分辨率的计时器，此外 kqueue 提供了一种方式除了内核提供的事件之外，还可以使用用户定义的事

l

产品：redis libevent

- [根据事件类型分配（Dispatch）给某个进程 / 线程*](https://www.zhihu.com/question/26943938)

> 疑问“

- 与`leaf-future`相比，这些Future本身并不代表I/O资源。 当我们对这些Future进行轮询时, 有可能会运行一段时间或者因为等待相关资源而让度给调度器,然后等待相关资源ready的时候唤醒自己.





- Rust 和其他语言的区别在于，在选择运行时时，您必须进行主动选择。大多数情况下，在其他语言中，你只会使用提供给你的那一种。

异步运行时可以分为两部分: 1. 执行器(The Executor) 2. reactor (The Reactor)

当 Rusts Futures 被设计出来的时候，有一个愿望，那就是将通知`Future`它可以做更多工作的工作与`Future`实际做工作分开。



异步运行时可以分为两部分: 1. 执行器(The Executor) 2. reactor (The Reactor)

当

1. [async-std](https://github.com/async-rs/async-std)
2. [Tokio](https://github.com/tokio-rs/tokio)



这就是Rust标准库所做的。 正如你所看到的，不包括异步I/O的定义,这些异步任务是如何被创建的,如何运行的。



https://github.com/async-rs/async-std



## 四 唤醒器和上下文(Waker and Context)

### 概述

1. 了解 Waker 对象是如何构造的
2. 了解运行时如何知道`leaf-future`何时可以恢复
3. 了解动态分发的基础知识和trait对象

`Waker`类型在[RFC#2592](https://github.com/rust-lang/rfcs/blob/master/text/2592-futures.md#waking-up)中介绍.



### 唤醒器

如果你想了解更多关于 Waker 类型背后的原因，我可以推荐Withoutboats articles series about them。


 创建一个 Waker 需要创建一个 vtable，这个vtable允许我们使用动态方式调用我们真实的Waker实现
 
 如果你想知道更多关于Rust中的动态分发，我可以推荐 Adam Schwalm 写的一篇文章 Exploring Dynamic Dispatch in Rust.
 
 #### Exploring Dynamic Dispatch in Rust
 
 
 
 
Let me preface this by saying that I am a novice in the world of rust (though I'm liking things so far!), so if I make technical mistakes please let me know and I will try to correct them. With that out of the way, lets get started.
首先我要说的是，我是 Rust 世界的新手（尽管到目前为止我很喜欢这些东西！），所以如果我犯了技术错误，请告诉我，我会尽力纠正它们。好了，让我们开始吧。


- 类似 c++ 虚函数 ？

- Vtables in Rust Rust 中的 Vtable



 1. 回顾 rust 特性  泛型和特征
 
 泛型和特征是 Rust 中最最重要的抽象类型，(c++template)
 
 在开始讲解 Rust 的泛型之前，先来看看什么是多态。


泛型就是一种多态
https://course.rs/basic/trait/generic.html

语法规则是什么
fn largest<T>(list: &[T]) -> T {
  

  2. 特征 Trait 类似c++虚函数，接口函数
  https://course.rs/basic/trait/trait.html

 
  
  特征对象的动态分发
回忆一下泛型章节我们提到过的，泛型是在编译期完成处理的：编译器会为每一个泛型参数对应的具体类型生成一份代码，这种方式是静态分发(static dispatch)，因为是在编译期完成的，对于运行期性能完全没有任何影响。

与静态分发相对应的是动态分发(dynamic dispatch)，在这种情况下，直到运行时，才能确定需要调用什么方法。之前代码中的关键字 dyn 正是在强调这一“动态”的特点。
  
  
  
  3. 下面这张图很好的解释了静态分发 Box<T> 和动态分发 Box<dyn Trait> 的区别：


  
 ![](https://files.mdnice.com/user/5197/1ee51d81-7ffb-426b-8650-cf6266a99333.png)
  
  这不是 多态条件  base =new child()
  
 
这就是我们将要关注的胖指针的类型。&dyn SomeTrait 是一个trait的引用，或者 Rust称之为一个trait对象。

指向 trait 对象的指针布局如下: - 前8个字节指向trait 对象的data - 后八个字节指向trait对象的 vtable


- 继续提问：rust dyn  用法 size of 举例
 
  
  在Rust中，`dyn`关键字通常用于创建 trait 对象，即在运行时动态调度的 trait 实现。你可以使用`std::mem::size_of`函数来获取 trait 对象的大小。以下是一个简单的示例：

```rust
trait SomeTrait {
    fn do_something(&self);
}

struct SomeStruct;

impl SomeTrait for SomeStruct {
    fn do_something(&self) {
        println!("Doing something!");
    }
}

fn main() {
    let trait_object: Box<dyn SomeTrait> = Box::new(SomeStruct);

    println!("Size of trait object: {}", std::mem::size_of_val(&trait_object));
}
```

在这个例子中，我们定义了一个`SomeTrait`，然后创建了一个结构体`SomeStruct`，并为其实现了`SomeTrait`。在`main`函数中，我们创建了一个`Box<dyn SomeTrait>`，并使用`std::mem::size_of_val`来获取 trait 对象的大小。

注意：trait 对象的大小是在运行时确定的，因为它需要包含指向实际对象的指针以及用于动态调度的其他信息。在上述例子中，输出的大小可能是8字节或16字节，具体取决于平台和编译器的实现。
  
  
  > 提示：这不就是c++ 多态吗？ c++对象模型
  
  
  稍后，当我们实现我们自己的 Waker 时，我们实际上会像这里一样建立一个 vtable。 我们创造它的方式略有不同，但是现在你知道了规则特征对象是如何工作的，你可能会认识到我们在做什么，这使得它不那么神秘
  
  

  这个例子 理解了 就是c++多态 。原理 多态增加 类成员。
  
  
 ## 五 生成器和async/await
1， 理解 async / await 语法在底层是如何工作的
  
2. 亲眼目睹(See first hand)我们为什么需要Pin
  
3. 理解是什么让 Rusts 异步模型的内存效率非常高
  
  生成器的动机可以在 RFC#2033中找到。 它写得非常好，我建议您通读它(它谈论async/await的内容和谈论生成器的内容一样多)
  
  https://github.com/rust-lang/rfcs/blob/master/text/2033-experimental-coroutines.md
  
  
  async/await is essentially the defacto standard nowadays when working with async I/O
  
 像 async/await 这样的语法本质上是当今使用异步 I/O 时的事实标准
  
  
-  了解 async/await 的预期语法 done
  
  https://www.boost.org/doc/libs/1_72_0/boost/asio/impl/awaitable.hpp 没看懂
  
  去提问：
  使用await 就能实现异步了，背后原理是什么？
  
  
  在 Rust 中，`async/await` 是一种语法糖，它简化了异步编程的写法。异步编程的核心是通过 Future 和 Stream trait 来表示异步计算和异步序列。

`async` 函数本质上返回一个 Future 对象。当你在异步函数内部使用 `await` 关键字时，它会暂停当前的执行流程，让出执行权，直到等待的 Future 完成。这使得程序可以在等待异步操作完成时执行其他任务，而不会阻塞整个线程。

背后的原理涉及到 Future、Executor 和 Poll 三个重要的概念：

1. **Future（未来）**: `async/await` 的核心是 Future trait，表示一个可能尚未完成的值或错误。`async` 函数返回的是一个实现了 Future trait 的对象。这个 Future 可以被异步运行时执行，它定义了如何在异步上下文中执行操作。

2. **Executor（执行器）**: 执行器负责实际执行 Future。异步运行时（例如 Tokio、async-std 等）充当执行器的角色，负责在合适的时机推进 Future 的执行。执行器可以管理线程池、任务队列等，确保异步任务能够按照正确的顺序执行。

3. **Poll（轮询）**: Future 的核心方法是 `poll`。当一个 Future 被轮询时，它会返回一个枚举值，表示当前是正在进行、已经完成，或者需要再次轮询。执行器根据这个返回值来决定是否将 Future 推进下一步。

当你在异步函数内使用 `await` 时，编译器会将其转换为一系列 Future 和 Poll 的调用，确保在等待异步操作时不会阻塞整个线程。
  
这样，整个异步链路可以在等待 IO、计时器等操作的同时，充分利用线程的资源执行其他任务，提高程序的并发性。
  
  https://github.com/rust-lang/rfcs/blob/master/text/2033-experimental-coroutines.md
  
  
  协程的级别比 future 本身要低一些。无堆栈协程功能不仅可用于 future，还可用于其他语言原语（如迭代器
  
  

  
  


