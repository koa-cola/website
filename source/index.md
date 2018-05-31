---
layout: default
id: index
title: koa-cola是什么?
next: ssr.html
---

[English version](https://koa-cola.github.io/)

[koa-cola](https://koa-cola.github.io/)是一个基于koa和react的服务器端SSR(server side render)和浏览器端的SPA(single page application)的web前后端全栈应用框架。

koa-cola使用typescript开发，使用d-mvc（es7 decorator风格的mvc）开发模式。另外koa-cola大量使用universal ("isomorphic") 开发模式，比如react技术栈完全前后端universal（server端和client端均可以使用同一套component、react-redux、react-router）。


* SSR+SPA的完整方案，只需要一份react代码便可以实现：服务器端渲染＋浏览器端bundle实现的交互
* 前后端同构，包括组件/路由/redux/ajax的同构
* 使用typescript开发
* 使用es7的decorator和async/await编码风格