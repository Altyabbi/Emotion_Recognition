<%--
  Created by IntelliJ IDEA.
  User: 30407
  Date: 2024/5/30
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="img/logo.ico" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Emotion-Detection_register</title>
    <link rel="stylesheet" href="css/index_register.css">
</head>
<body>

<div class="loading">
    <svg viewBox="0 0 50 50">
        <circle r="25" cx="25" cy="25"></circle>
    </svg>
    <p>Loading...</p>
</div>

<div class="facet_r">
    <h1>Welcome to sign up <br> for our E-D SYS</h1>
    <div class="emotions">
        <img src="img/angry.png" alt="">
        <img src="img/moved.png" alt="">
        <img src="img/yummy.png" alt="">
        <img src="img/logo.png" alt="">
        <img src="img/love.png" alt="">
        <img src="img/cry.png" alt="">
        <img src="img/sad.png" alt="">
    </div>
</div>
<div id="reg_content">
    <tr class="center">
        <form id="form_" method="post" action="http://localhost/web_demo_war/Register">
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
                        <span id="passwordMatch" class="required">*</span></td>
                </tr>
                <tr>
                    <td class="left"><label for="Telephone">手机号</label></td>
                    <td class="right"><input type="text" pattern="[0-9]{11}" name="telephone" placeholder="请输入您的手机号" id="telephone">
<%--                        <span class="required">*</span></td>--%>
                </tr>
                <tr>
                    <td class="left"><label>性别</label></td>
                    <td class="right">
                        <input type="radio" name="gender" value="male" checked>男
                        <input type="radio" name="gender" value="female">女
<%--                        <span class="required">&nbsp;&nbsp;*</span></td>--%>
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
                <tr id="btn">
                    <td colspan="2" class="already">
                    <button type="submit" id="sub_btn"><strong>注册</strong></button>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="already">
                        <p>已有账号?&nbsp;<a href="http://localhost/web_demo_war/index.jsp">立即登录</a></p>
                    </td>
                </tr>
            </table>

        </form>

    </div>
</div>
</body>
<%--校验两次密码输入是否一致--%>
<script>
    document.addEventListener('DOMContentLoaded',function (){
        // 获取密码输入框和确认密码输入框
        const passwordInput = document.getElementById('password');
        const password2Input = document.getElementById('password2');
        const passwordMatchSpan = document.getElementById('passwordMatch');
        const sub_btn = document.getElementById('sub_btn');

        // 添加事件监听器，检查密码是否一致
        password2Input.addEventListener('input', function() {
            const password = passwordInput.value;
            const password2 = password2Input.value;

            if (password === password2 && password !== '' && password2 !== '') {
                // 如果密码一致且都不为空，显示对号
                passwordMatchSpan.textContent = '✔';
                passwordMatchSpan.style.color = 'green';
                passwordMatchSpan.style.fontSize = '10px';
            } else {
                // 如果密码不一致或为空，显示叉号
                passwordMatchSpan.textContent = '✘';
                passwordMatchSpan.style.color = 'red';
                passwordMatchSpan.style.fontSize = '10px';
            }
        });

        // 表单提交时再次检查密码是否一致
        document.getElementById('form_').addEventListener('submit', function(event) {
            const password = passwordInput.value;
            const password2 = password2Input.value;

            if (password !== password2) {
                alert('密码不匹配，请重新输入！');
                event.preventDefault(); // 阻止表单提交
                password2Input.value = ''; // 清空确认密码输入框
            }
        });
    })

</script>
<%--加载动画--%>
<script>
    const loading={
        container: document.querySelector(".loading"),
        in(target){
            this.container.classList.remove("loading_out");
            setTimeout(() => {
                window.location.href = target;
            }, 1000)
        },
        out(){
            this.container.classList.add("loading_out");
        }
    };
    window.addEventListener("load",() => {
        loading.out();
    })
</script>
</html>
