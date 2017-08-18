---
layout: default
id: d-mvc
title: decorator的mvc开发模式
prev: universal.html
next: installation.html
---

koa-cola可以使用es7的decorator装饰器开发模式来写mvc，controller是必须用提供的decorator来开发（因为涉及到router相关的定义），model和view层则没有强制需要demo所演示的decorator来开发。
### Controller
    
使用decorator装饰器来注入相关依赖，路由层的decorators包括router、中间件、response、view，响应阶段的decorators包括koa.Context、param、response、request等，比如以下例子：

```javascript
const { Controller, Get, Use, Param, Body, Delete, Put, Post, QueryParam, View, Ctx, Response } = require('koa-cola').Decorators.controller;
@Controller('') 
class FooController {
    @Get('/some_api')  // 定义router以及method
    @Response(Ok)       // 定义数据返回的结构
    some_api (@Ctx() ctx, @QueryParam() param : any) { // 注入ctx和param
        // 初始化数据，数据将会以“Ok”定义的格式返回
        return {
            foo : 'bar'
        }
    }

    @Get('/some_page')  // 定义router以及method
    @View('some_page')
    some_page (@Ctx() ctx, @QueryParam() param : any) { // 注入ctx和param
        // 初始化数据，数据将会注入到react组件的props，如：this.props.ctrl.foo
        return {
            foo : 'bar'
        }
    }
}
```


因为使用decorator定义router，所以在koa-cola里面不需要单独定义router。

### View

view层可以是简单的React.Component或者是stateless的函数组件，也可以是使用官方的react-redux封装过的组件，todolist demo的view则是使用了[redux-connect](https://github.com/makeomatic/redux-connect) 提供的decorator(当然你也可以直接用它的connect方法)，redux-connect也是基于react-redux，以下是view层支持的react组件类型。
    
#### React.Component组件

```javascript
    class Index extends React.Component<Props, States>   {
        constructor(props: Props) {
            super(props);
        }
        static defaultProps = {
            
        };
        render() {
            return <h1>Wow koa-cola!</h1>
        }
    };
    export default Index
```

#### stateless组件

```javascript
    export default function({some_props}) {
        return <h1>Wow koa-cola!</h1>
    }
```

#### react-redux组件

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

#### redux-connect的decorator
使用这种方式的话，需要注意两点：
* redux的reducer需要使用装饰器colaReducer
* 如果有子组件也是使用redux-connect封装，则需要使用装饰器include
* 以上两点可以参考todolist的[代码](https://github.com/koa-cola/todolist/blob/master/views/pages/colastyleDemo.tsx)

```javascript
import AddTodo from '../official-demo/containers/AddTodo';
import FilterLink from '../official-demo/containers/FilterLink';
import VisibleTodoList from '../official-demo/containers/VisibleTodoList';
const {
  asyncConnect,
  colaReducer,
  include
} = require('koa-cola').Decorators.view;
@asyncConnect([
  {
    key: 'todosData',
    promise: async ({ params, helpers, store: { dispatch } }) => {
      const api = new GetTodoList({});
      const data = await api.fetch(helpers.ctx);
      dispatch({
        type: 'INIT_TODO',
        data: data.result.result
      });
      return data.result.result;
    }
  }
])
@colaReducer({
  todos,
  visibilityFilter
})
@include({ AddTodo, FilterLink, VisibleTodoList })
class ColastyleDemo extends React.Component<Props, States> {
  constructor(props: Props) {
    super(props);
  }
  render() {
    return <App />;
  }
}
export default ColastyleDemo;
```

#### 自定义header和bundle方式

koa-cola渲染页面时，默认会找views/pages/layout.ts封装页面的html，如果没有这个layout文件，则直接输出page组件的html，如果view组件使用了doNotUseLayout decorator，则页面不会使用layout.ts输出，这时你可以自定义header和bundle的decorator。

```javascript
import * as React from 'react';
const {
  header, bundle, doNotUseLayout
} = require('../../../dist').Decorators.view;
@doNotUseLayout
@bundle([
  "/bundle.js",
  "/test.js"
])
@header(() => {
  return <head>
    <meta name="viewport" content="width=device-width" />
  </head>
})
function Page (){
  return <h1>koa-cola</h1>
};
export default Page
```

### Model
和必须使用decorator的controller层、必须使用react组件的view层不一样，model层是完全没有耦合，你可以使用任何你喜欢的orm或者odm，或者不需要model层也可以，不过使用koa-cola风格的来写model，你可以体验不一样的开发模式。

#### 你可以直接在目录api/models下创建如user.ts：
```javascript
import * as mongoose from 'mongoose'
export default mongoose.model('user', new mongoose.Schema({
    name : String,
    email : String
}))
```

然后就可以在其他代码里面使用：
```javascript
const user = await app.models.user.find({name : 'harry'})
```

#### 使用koa-cola的风格写model

首先在`api/schemas`目录创建user.ts

```javascript
export const userSchema = function(mongoose){
    return {
        name: {
            type : String
        },
        email : {
            type : String
        }
    }
}
```

在目录`api/models`下创建model如user.ts：
```javascript
import * as mongoose from 'mongoose'
import userSchema from '../schemas/user'
export default mongoose.model('user', new mongoose.Schema(userSchema(mongoose)))
```

当然也可以使用decorator方式定义model，还可以定义相关hook，详情可以参考[mongoose-decorators](https://github.com/aksyonov/mongoose-decorators)

```javascript
import { todoListSchema } from '../schemas/todoList';
const { model } = app.decorators.model;

@model(todoListSchema(app.mongoose))
export default class TodoList {}
```

使用cli生成model的schema

`koa-cola --schema` 自动生成model的接口定义在`typings/schema.ts`

然后你可以在代码通过使用typescript的类型定义，享受vscode的intellisense带来的乐趣
```javascript
import {userSchema} from './typings/schema' 
const user : userSchema = await app.models.user.find({name : 'harry'})
```

在前面提到的为什么需要在api/schemas定义model的schema，除了上面可以自动生成schema的接口，这部分可以在浏览器端代码复用，比如数据Validate。详细可以查看[文档](http://mongoosejs.com/docs/browser.html)

#### koa-cola提供了前后端universal的api接口定义，比如todolist demo的获取数据的接口定义

```javascript
import { todoListSchema } from './typings/schema';
import { ApiBase, apiFetch } from 'koa-cola';

export class GetTodoList extends ApiBase<
  {
      // 参数类型
  },
  {
    code: number;
    result: [todoListSchema];
  },
  {
      // 异常定义
  }
> {
  constructor(body) {
    super(body);
  }
  url: string = '/api/getTodoList';
  method: string = 'get';
}
```

在代码里面使用api，并享受ts带来的乐趣：
```javascript
const api = new GetTodoList({});
const data = await api.fetch(helpers.ctx);
```

<img src="https://github.com/hcnode/koa-cola/raw/master/screenshots/api1.png" alt="Drawing" width="600"/>
<img src="https://github.com/hcnode/koa-cola/raw/master/screenshots/api2.png" alt="Drawing" width="600"/>

又比如参数body的定义，如果定义了必传参数，调用时候没有传，则vscode会提示错误
```javascript
import { testSchema } from './typings/schema';
import { ApiBase, apiFetch } from 'koa-cola'
export interface ComposeBody{
    foo : string,
    bar? : number
}
export class Compose extends ApiBase<ComposeBody, testSchema, {}>{
    constructor(body : ComposeBody){
        super(body)
    }
    url : string = '/compose'
    method : string = 'post'
}
```
<img src="https://github.com/hcnode/koa-cola/raw/master/screenshots/api3.png" alt="Drawing" width="600"/>
