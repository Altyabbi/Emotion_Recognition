<%--
  Created by IntelliJ IDEA.
  User: 30407
  Date: 2024/6/17
  Time: 20:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link rel="icon" href="img/logo.ico" type="image/x-icon">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Emotion-Detection_register</title>
  <link rel="stylesheet" href="test.css">
</head>
<body>
<div id="reg_content">
  <div class="center">
    <form method="post" action="http://localhost/web_demo_war/Register">
      <table>
        <tr>
          <td class="left"><label for="username">用户名</label></td>
          <td class="right"><input type="text" name="username" placeholder="请输入用户名" id="username" required>
            <span class="required">*</span></td>
        </tr>

        <tr>
          <td class="left"><label for="password">密码</label></td>
          <td class="right"><input type="password" name="password" placeholder="请输入密码" id="password" required>
            <span class="required">*</span></td>
        </tr>

        <tr>
          <td class="left"><label for="password2">确认密码</label></td>
          <td class="right"><input type="password" name="password" placeholder="请确认密码" id="password2" required>
            <span class="required">*</span></td>
        </tr>
        <tr>
          <td class="left"><label for="Telephone">手机号</label></td>
          <td class="right"><input type="text" pattern="[0-9]{11}" name="telephone" placeholder="请输入您的手机号" id="telephone" required>
            <span class="required">*</span></td>
        </tr>
        <tr>
          <td class="left"><label>性别</label></td>
          <td class="right">
            <input type="radio" name="gender" value="male" checked>男
            <input type="radio" name="gender" value="female">女
            <span class="required">&nbsp;&nbsp;*</span></td>
        </tr>

        <tr>
          <td class="left"><label for="Email">Email</label></td>
          <td class="right"><input type="email" name="email" placeholder="请输入Email" id="Email">
          </td>
        </tr>

        <tr>
          <td class="left"><label for="Birthday">出生日期</label></td>
          <td class="right"><input type="date" name="birthday" id="Birthday"></td>
        </tr>

      </table>
    </form>
    <div class="already">
      <button type="submit"><strong>注册</strong></button>
      <p>已有账号?&nbsp;<a href="http://localhost/web_demo_war/index.jsp">立即登录</a></p>
    </div>
  </div>
</div>
</body>
</html>
