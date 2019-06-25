---
layout: default
id: universal-redux
title: 前后端redux
prev: universal-router.html
next: universal-component.html
---



### 前后端redux

koa-cola集成了react-redux方案

server端redux:

#### 使用react-redux组件，但是无法获得controller返回的props

```javascript
import { connect } from 'react-redux'
const Index = function({some_props}) {
    return <h1>Wow koa-cola!</h1>
}
export default connect(
    mapStateToProps,
    mapDispatchToProps
)(Index)
```

或者是经过Cola装饰器封装的react-redux:

```javascript
const {Cola} = require('koa-cola/client');

@Cola({
    initData : {
        foo : async ({ params, helpers}) => {
            return await Promise.resolve('this will go to this.props.some_props')
        }
    },
    mapStateToProps,
    mapDispatchToProps
})
class Index extends React.Component<Props, States>   {
    constructor(props: Props) {
        super(props);
    }
    render() {
        return <h1>{this.props.foo}</h1>
    }
};
export default Index
```

client端的redux

在client可以使用上面所有形式的react组件的redux数据流开发模式，并且没有server端只能在render前使用的限制，可以在组件的生命周期任何时候使用。

但是client端的redux store会依赖server端，如果server端的store已经经过一系列的数据流操作，那么将会在render阶段之前的数据保存起来，作为client端react-redux的初始化数据（详细查看[redux的createStore](http://redux.js.org/docs/api/createStore.html)），那么这样就可以完美地redux数据流从server端无缝衔接到client端。