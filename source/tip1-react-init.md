---
layout: default
id: tip1-react-init
title: 初始化react组件数据
next: tip2-redux.html
---

使用Cola装饰器的组件初始化数据

```javascript
const {Cola} = require('koa-cola/client');

// 变量描述
export interface Props {
    foo: string;   
}
export interface States {}

@Cola({
  initData : {
    foo : async ({ params, helpers, store: { dispatch } }) => {
        return await Promise.resolve('bar');
    }
  }
})
class Some_Page extends React.Component<Props, States> {
  constructor(props: Props) {
    super(props);
  }
  render() {
    return <div>{this.props.foo}</div>;
  }
}
export default Some_Page;
```

这两种方式的区别是：

第一种方式：
* 只会在服务器端进行初始化
* 只支持React.Component和function的react组件
* 因为只会在服务器端进行初始化，所以可以支持任何获取数据的方式比如数据库获取

第二种方式：
* 服务器端和浏览器端都支持（服务器端就是SSR，浏览器端就是异步获取数据）
* Cola装饰器的组件
* 因为服务器端和浏览器端都支持初始化，所以数据的获取必须支持前后端，比如使用axios库