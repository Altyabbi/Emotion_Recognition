`<%--
  Created by IntelliJ IDEA.
  User: 30407
  Date: 2024/6/11
  Time: 15:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="img/logo.ico" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Emotion-Detection_login</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>

<div class="loading">
    <svg viewBox="0 0 50 50">
        <circle r="25" cx="25" cy="25"></circle>
    </svg>
    <p>Loading...</p>
</div>

<div id="login-box">
    <form method="post" action="http://localhost/web_demo_war/Login">
        <img src="img/logo.png" alt="" class="breath-effect">
        <h1>Welcome to E-D SYS</h1>
        <div class="form">
            <div class="item">
                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                <input type="text" name="username" placeholder="Username" required />
            </div>
            <div class="item">
                <i class="fa fa-key" aria-hidden="true"></i>
                <input type="password" name="password" placeholder="Password" required />
            </div>
        </div>
        <button type="submit"><strong>Login</strong></button>
        <div class="link">
            <a href="http://localhost/web_demo_war/register.jsp" class="a1"><strong>Register</strong></a>
            <a>|</a>
            <a href="visitor.jsp" class="a2"><strong>Visitor</strong></a>
        </div>
    </form>
</div>
<div class="footer">
    <div class="copyright">
        Copyright © 2024-06-15
        <strong>Emotion Detection</strong>
        &nbsp;<!--空格-->
        By zbl zyz zs sjh
    </div>
</div>
</body>
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
