---
layout: default
id: tip4-cluster
title: cluster集群模式
prev: tip3-inject-global.html
next: tip5-debug.html
---

如果想使用cluster模式，koa-cola提供了pm2的配置文件，使用cli新建项目时候会生成这个配置文件，启动方式使用：`pm2 start pm2.config.js`

或者你可以自定义pm2的配置，配置interpreter参数为ts-node

```javascript
{
    name: 'koa-cola-app',
    script: __dirname + '/app.ts',
    instances: 2,
    interpreter: 'ts-node',
    exec_mode: 'cluster'
}
```