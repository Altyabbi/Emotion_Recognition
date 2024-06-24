# 【用户】  
## 数据库用户表
- `login_sql`(MySQL)  

*jdbc:mysql://localhost:3306/login_sql*  
*账号：root；密码：root*
## 前端
- `index.jsp`首页  


- `login.jsp`登录页面  
  【用户登录JS校验】
  - 给登录按钮绑定点击事件
  - 获取用户姓名和密码信息
  - 判断姓名是否为空：如果为空，提示用户（span标签赋值）return
  - 判断密码是否为空：如果为空，提示用户（span标签赋值）return
  - 如果都不为空，手动提交表单进行登录

- `register.jsp`注册界面

## 后端
- `usermapper`登录功能