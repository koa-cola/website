---
layout: default
id: cli
title: Cli命令
prev: installation.html
---

koa-cola提供了一些有用的cli命令，包括新建项目、启动项目、生成model schema文件

### 创建koa-cola项目

`koa-cola new app` 或者 `koa-cola n app` 在当前目录创建文件夹名字为app的模版项目，并自动安装依赖，和自动build bundle和启动应用。

### 启动应用

`koa-cola` 在项目目录里面执行，启动项目，node端启动app项目，但是不会build bundle

`koa-cola cheer` 或者 `koa-cola c` 先build bundle，再launch app

**windows环境使用koa-cola命令启动可能有问题，可以尝试以下方式启动**

* 先安装全局的ts-node `npm i ts-node -g`
* 使用ts-node运行 `ts-node ./app.ts`

### 生成model schema文件

`koa-cola schema` 或者 `koa-cola s` 生成`api/schenmas`下面的model schema定义，保存在`typings/schema.ts`
