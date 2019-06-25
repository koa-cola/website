---
layout: default
id: universal-api
title: 前后端api
prev: universal-component.html
next: universal-validation.html
---



### http api和请求fetch

在前面介绍，也说到过可以使用koa-cola定义的api基类来创建自己的api类，并使用api的fetch方法获取数据：

```javascript
const api = new GetTodoList({});
const data = await api.fetch(helpers.ctx);
```

上面代码可以兼容服务器端和客户端，ajax库使用了[axios](https://github.com/mzabriskie/axios)，比如 [todolist demo](https://github.com/koa-cola/todolist) 有个react组件定义：

```javascript
@Cola({
    initData : {
        todosData : async ({ params, helpers, store: { dispatch } }) => {
            const api = new GetTodoList({});
            const data = await api.fetch(helpers.ctx);
            return data.result.result;
        }
    }
})
class Page extends React.Component<Props, States> {
  ...
}
export default Page;
```
如果该组件的路由是服务器端直接渲染，则`api.fetch`会在服务器端调用，如果该组件是在浏览器端的`<Link>`跳转，则`api.fetch`会在浏览器端调用。