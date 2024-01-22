

### 2024-1-21

学习内容：

https://shimo.im/docs/47kgMxb6jZu7G13V

#### 林晨-BITcyman

进展日志 & 学习笔记： https://github.com/BITcyman/Rust-os-learning

1. 学习 杨凯豪同学的工作（[在 rcore中 引入异步驱动](https://github.com/lighkLife/rCore-async/tree/ch9-async)） 
2. 学习 rCore-N 的异步串口 （[笔记](https://github.com/BITcyman/Rust-os-learning/blob/main/rCore-N.md)）
3. 正在尝试把 异步串口驱动 写成独立的crate （[笔记](https://github.com/BITcyman/Rust-os-learning/blob/main/driver/uart-crate.md)、[仓库](https://github.com/BITcyman/async-uart-driver/tree/main)）

- 串口驱动依赖embassy吗？目前没有依赖，需要添加 embassy 依赖
- 异步驱动对上的接口？可参考smotcp的接口定义；
- 同步驱动；把 pac 也独立成 crate

学习收获：

遇到问题：



# 项目六：基于协程异步机制的操作系统/驱动



### **项目目标：**

基于Rust语言的异步支持和已有的用户态中断、共享调度器和异步驱动框架embassy等工作，在rCore-N或seL4操作系统上引入异步机制，实现内核态或用户态的设备驱动，以及调度器等内核模块的异步改造。

### **项目内容：**

1. Rust语言的异步机制；

2. 用户态中断；

3. 设备驱动的异步框架embassy；

4. 以协程为调度单位的共享调度器；

   

## 任务一： Embassy 文档翻译
| 序号  | 任务  | 状态  | 结果  |
| --- | --- | --- | --- |
| 1   | 看教学视频 | 完成 | 《操作系统专题训练课》.md |
| 2   | 学习携程实现 | 完成 | futures_explained_in_200_lines_of_rust.md |
| 3   | 翻译 Embassy Doc | 进行中 |  |

## 任务二： 开发和移植跨OS的异步驱动

| 序号  | 任务  | 状态  | 结果  |
| --- | --- | --- | --- |
| 1   | 学习 Async Rust vs RTOS showndown | 进行中 |  |
| 2   | 异步驱动实现 | 进行中 | |
| 3   | 驱动移植 |  | |

