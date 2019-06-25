---
layout: default
id: universal-validation
title: 前后端validation
prev: universal-api.html
---

## 前后端validation(v0.7版本)

### 新建validation配置，配置会在客户端和服务器端使用

/config/validators.js

```javascript
module.exports = {
    validators : {
         form : {
            path: '/validatePost', // 需要验证的url，包括浏览器端的form提交前的验证，以及服务器端的中间件的验证
            fields: [
                {
                    // 允许空的字段
                    name: 'allowEmpty', 
                    allowEmpty: true
                },
                {
                    // 不允许为空的字段，并且提供了验证的正则表达式
                    name: 'account',
                    validate: /[0-9a-zA-Z]{6,}/ig,
                    allowEmpty: false,
                    msg: '不能为空'
                },
                {
                    // 不允许为空的字段，并且提供了验证的函数
                    name: 'number',
                    validate: value => {
                        return /\d+/.test(value)
                    },
                    allowEmpty: false,
                    msg: '必须为数字'
                }
            ],
            onError: msg => {
                alert(msg)
            }
        }
    }
}
```

### view组件

```typescript
import * as React from 'react';
import {validateForm} from "../../../client"
import {validators} from '../../config/validators'
import axios from 'axios'
// hoc组件，通过配置的validation生成ValidateForm
var ValidateForm = validateForm(validators.form);
class Page extends React.Component<any, any>   {
  constructor(props: any) {
      super(props);
      this.state = {body : {}, result : {}};
  }
  validateForm = null
  render() {
    return <div>
      <ValidateForm ref={instance => { this.validateForm = instance; }}>
        allow empty:&nbsp;<input type="text" name="allowEmpty"/><br/>
        account:&nbsp;<input type="text" name="account"/><br/>
        number:&nbsp;<input type="text" name="number"/><br/>
        <input type="submit" value="submit by posting form"/>&nbsp;
        <input type="button" value="get post data by validate" onClick={() => {
          var body = this.validateForm.getBody();
          this.setState({body})
        }} />&nbsp;
        {/* 以下按钮绕过浏览器端验证直接提交到服务器，结果返回400 */}
        <input type="button" value="post data by ajax" onClick={async () => {
          try {
            var result = await axios({
              url : validators.form.path,
              method : 'post',
              data : this.state.body
            })
            this.setState({result : result.data})
          } catch (error) {
            console.log(error)
          }
        }} />
      </ValidateForm>
      <div>
        post body:{JSON.stringify(this.state.body)}
      </div>
      <div>
        result:{JSON.stringify(this.state.result)}
      </div>
    </div>
  }
};
export default Page
```