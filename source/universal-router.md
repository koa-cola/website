---
layout: default
id: universal-router
title: 前后端router
next: universal-redux.html
---


### 前后端router

通过controller生成server端的react-router，并且也生成client端的react-redux的Provider(里面还是封装了react-router)

```javascript
@Controller('') 
class FooController {
    @Get('/')
    @View('index')
    index(@Ctx() ctx) {
        return '<h1>hello koa-cola !</h1>'
    }
}
```
自动生成的server端的react-router:

```html
<Router ... >
    <Route path="/" component={IndexComponent} />
</Router>
```

通过react-router的match到对应的route后，再通过Provider，最终渲染出html：
```html
<Provider store={store} key="provider">
    <SomeReduxComponent />
</Provider>
```


client端Provider则是:
```html
<Provider store={store} key="provider">
    <Router ... >
        <Route path="/" component={IndexComponent} />
    </Router>
</Provider>
```