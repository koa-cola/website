---
layout: default
id: installation
title: 如何使用
prev: d-mvc.html
next: cli.html
---


koa-cola支持node.js的版本包括7.6和8，建议使用8，因为8.0使用的最新的v8版本，而且8.0会在[今年10月正式激活LTS](https://github.com/nodejs/LTS)，因为koa-cola的async/await是原生方式使用没有经过transform成es6，所以不支持node7.6以下的node版本。

开发者可以通过两种开发模式进行koa-cola项目开发

1. 基于模版的文件结构方式创建koa-cola项目，通过这种方式创建出完整的项目工程，适合大型的web项目开发。
    * `npm i koa-cola ts-node -g`
    * `koa-cola n app` 在当前文件夹创建名字为app的新koa-cola项目，创建完整的目录结构，并自动安装依赖
    * `cd app`
    * `koa-cola -c` 执行webpack build bundle，并启动项目
    * 访问[http://localhost:3000](http://localhost:3000)
    (在开发环境，可以使用`npm run watch`和`npm run local`进行开发)

2. 使用api方式创建项目，通过这种方式，可以几分钟内部署好koa-cola项目，适合简单的项目开发。
    * `npm i koa-cola ts-node -g`
    * `koa-cola n app m api` 在目录里面创建api.tsx,package.json,tsconfig.json, 并自动安装依赖和启动项目
    * 访问[http://localhost:3000](http://localhost:3000)
    (在开发环境，可以使用`npm run local`进行开发)

api模式只需要一个app.tsx即可启动一个koa-cola web服务：

```javascript
import * as React from 'react'
var {RunApp} = require('koa-cola')
var { Controller, Get, Use, Param, Body, Delete, Put, Post, QueryParam, View, Ctx, Response } = require('koa-cola').Decorators.controller;
@Controller('') 
class FooController {
    @Get('/')
    index(@Ctx() ctx) {
        return '<h1>hello koa-cola !</h1>'
    }

    @Get('/view')
    @View('some_view')
    async view( @Ctx() ctx ) { 
        return await Promise.resolve({
            foo : 'bar'
        });
    } 
}
RunApp({
    controllers: {
        FooController: FooController
    },
    pages: {
        some_view : function({ctrl : {foo}}){
            return <div>{foo}</div>
        }
    }
});

```
