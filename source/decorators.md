---
layout: default
id: decorators
title: 装饰器
prev: installation.html
next: cli.html
---

# Cola 装饰器
用来定义redux数据初始化，react-redux组件的mapStateToProps和mapDispatchToProps定义，和redux的reducer定义，装饰器可以同时支持服务器端和浏览器端。

```javascript
@Cola({
  initData: {
    todos : async () => {
        return await Promise.resolve([])
    }
  },
  mapStateToProps: ({  }) => {
    return {
      
    };
  },
  mapDispatchToProps: dispatch => {
    return {
      
    };
  },
  reducer: {
    
  }
})
class App extends React.Component<Props, States> {

}
```