---
layout: default
id: installation
title: 如何使用
prev: d-mvc.html
next: cli.html
---


koa-cola支持node.js的版本包括7.6和8，建议使用8，因为8.0使用的最新的v8版本，而且8.0会在[今年10月正式激活LTS](https://github.com/nodejs/LTS)，因为koa-cola的async/await是原生方式使用没有经过transform成es6，所以不支持node7.6以下的node版本。

* `npm i koa-cola ts-node -g`
* `koa-cola new app` 在当前文件夹创建名字为app的新koa-cola项目，创建完整的目录结构，并自动安装依赖
* `cd app`
* `koa-cola cheer` 执行webpack build bundle，并启动项目
* 访问[http://localhost:3000](http://localhost:3000)
(在开发环境，可以使用`npm run watch`和`npm run local`进行开发)

