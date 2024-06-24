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
    <title>Emotion-Detection</title>
    <link rel="stylesheet" href="css/index_register.css">
</head>
<body>

<div class="facet_i">
    <h1>Hi~Test your Emotions Here.<br>Come and Join us!</h1>
    <div class="emotions">
        <img src="img/angry.png" alt="">
        <img src="img/moved.png" alt="">
        <img src="img/yummy.png" alt="">
        <img src="img/logo.png" alt="">
        <img src="img/love.png" alt="">
        <img src="img/cry.png" alt="">
        <img src="img/sad.png" alt="">
    </div>
    <div class="btns">
        <button type="submit" onclick=jump('./register.jsp')><strong>SIGN UP</strong></button>
        <button type="submit" onclick=jump('./login.jsp')><strong>LOGIN</strong></button>
    </div>

    <script>
        function jump(target) {
            window.location.href = target;
        }
    </script>
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

</html>
