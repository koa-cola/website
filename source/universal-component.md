---
layout: default
id: universal-component
title: 前后端react组件
prev: universal-redux.html
next: universal-api.html
---




### react组件的前后端复用

从前面react-router和react-redux可以看到react组件是可以完全前后端复用，在前端可以使用react所有功能，但是在server端只能使用render之前的生命周期，包括：

* constructor()
* componentWillMount()
* render()

如果你的组件会依赖浏览器的dom，如果是在以上生命周期里面调用，则在server端渲染时出错，所以避免出错，你需要判断当前环境，比如：`if(typeof window != 'undefined')`，或者你可以使用这个类似[模拟浏览器端方案](https://github.com/airbnb/enzyme/blob/master/docs/guides/jsdom.md)。