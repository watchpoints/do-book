---
title: "跟着tikv源码学rust P01"
date: 2023-05-05
description: "Tidb"
draft: false
tags: ["Tidb"]
---





## # day1:5分钟系列--安装单节点tidb



今天是tidb100天探索之游学习第一天

## centos ：

~~~

资料：
 https://asktug.com/t/topic/1007869
 https://download.pingcap.com/docs-cn%2FLesson07_quick_start.mp4

必须centos 
centos  root用户登录 ，ubuntu遇到其他问题

免密设置：
ssh-keygen
ssh-copy-id root@127.0.0.1 

磁盘
mkfs.ext4 /dev/nvme0n2
mount /dev/nvme0n2  /mnt/tidb


## 安装tiup
curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
source /root/.bash_profile
tiup install cluster

配置模板：
https://github.com/pingcap/tiup/blob/master/embed/examples/cluster/minimal.yaml 模板
lscpu 默认

// tiup cluster deploy <cluster-name> <version> <topology.yaml> [flags]
tiup cluster deploy tidb7.5 7.5.0 ./minimal_centos.yaml

查看集群列表
tiup cluster list

启动集群
tiup cluster start tidb7.5

检查集群状态
tiup cluster display tidb7.5

禁用开启启动
tiup cluster disable tidb7.5

删除集群
tiup cluster destroy watchpoints
yum -y install mysql
# help
- https://docs.pingcap.com/zh/tidb/dev/quick-start-with-tidb
- https://asktug.com/t/topic/1019413
- https://asktug.com/t/topic/1018622
- ttps://docs.pingcap.com/zh/tidb/stable/tiup-cluster [反复看]
- https://docs.pingcap.com/zh/tidb/stable/check-before-deployment

~~~



## #day2  分钟系列--编译tikv 并替换



###  1. what:



### 2. why: 



### 3. how：



- rust 搭建

~~~


rsproxy.cn - 字节跳动新的 crates.io 和 rustup 的国内镜像源
步骤一：设置 Rustup 镜像， 修改配置 ~/.zshrc or ~/.bashrc

export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
步骤二：安装 Rust
curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh
source "$HOME/.cargo/env"

rustc --version
rustc 1.75.0 (82e1608df 2023-12-21)

步骤三：设置 crates.io 镜像， 修改配置 ~/.cargo/config
[source.crates-io]
replace-with = 'rsproxy-sparse'
[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"
[source.rsproxy-sparse]
registry = "sparse+https://rsproxy.cn/index/"
[registries.rsproxy]
index = "https://rsproxy.cn/crates.io-index"
[net]
git-fetch-with-cli = true

~~~



- centos8 源码编译

~~~、
依赖： build-essential

yum update # 这个和很慢
yum groupinstall "Development Tools"

依赖： openssl
yum install openssl openssl-devel -y
dnf --enablerepo=powertools install protobuf-devel



Centos安装Protobuf：
cargo install protobuf-codegen
cargo install grpcio-compiler

或者
https://github.com/protocolbuffers/protobuf/releases/download/v25.2/protoc-25.2-linux-x86_64.zip
cp -rf bin /bin
cp -rf include/ /usr/local/

dnf install cmake

git 免密设置
cat ~/.ssh/id_rsa.pub

git clone https://github.com/watchpoints/tikv.git
git submodule update --init --recursive



cargo build

直接把我虚机编译无法登录了，改为2g云服务器。慢


~~~

- 解决GitHub网络波动严重

~~~
遇到问题：
Failed to connect to github.com port 443: 拒绝连接
需要魔法棒

nslookup命令用于查询DNS的记录，查看域名解析是否正常
nslookup github.com
非权威应答:
名称:    github.com
Address:  20.205.243.166

20.205.243.166 github.com
104.244.46.246 github.global.ssl.fastly.net
20.205.243.165 codeload.github.com



~~~



说明： 编译依赖能解决如下问题：

~~~
error: failed to run custom build command for `protobuf-src v1.1.0+21.5  
https://asktug.com/t/topic/1020903

CMake Error at CMakeLists.txt:38 
c++ is not a full path and was not found in the PATH.
Tell CMake where to find the compiler by setting either the environment


~~~





4. 相关资料

- https://asktug.com/t/topic/996395

  

# 一、问题是什么



- 阅读文章：https://asktug.com/t/topic/693645

- 【源码合集】TiKV 源码阅读三部曲

  https://mp.weixin.qq.com/s/HgflwnZZMHXaIsFV3PdGAg

- 阅读  Rust 参考手册 中文版
  https://rustwiki.org/zh-CN/reference/expressions/if-expr.html

开始时间：2023-05-05

结束时间：2023-06-05 

期望一个月内

# 二、如何分析的


### TiKV 源码阅读三部曲（一）重要模块

本小节将简单介绍 KVService 及其启动流程，并顺带介绍 TiKV 若干重要结构的初始化流程


### TiKV 源码阅读三部曲（二）读流程

本小节将在 TiKV 6.1 版本的源码基础上，以一条读请求为例，介绍当前版本读请求的全链路执行流程。

- https://github.com/pingcap/kvproto/blob/master/proto/tikvpb.proto#L20
  rpc KvGet(kvrpcpb.GetRequest) returns (kvrpcpb.GetResponse) {}

- KVService



# 三、如何解决的



文章地址

- http://localhost:1313/post/tidb/20230_05_05_tikv/

- https://wangcy6.github.io/post/tidb/2022/tidb_01/





