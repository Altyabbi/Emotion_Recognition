<%--
  Created by IntelliJ IDEA.
  User: 30407
  Date: 2024/6/24
  Time: 9:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="img/logo.ico" type="image/x-icon">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>FAST_VERSION Real-Time Face Emotion Detection</title>
    <script defer src="./js/face-api.min.js"></script>
    <script defer src="./js/script_FV.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
    <link rel="stylesheet" href="./css/style_FV.css">
</head>
<body>
<div class="loading" id="loading">
    <span>Loading FV_models</span>
</div>
<div id="top" class="top">
    <div class="logo">
        <img src="./img/logo.png" alt="Logo">
        <span>Emotion-Detection system</span>
    </div>
    <div class="user-greeting">
        <div id="wel_text">Hi~ <%= session.getAttribute("LoginUserName") %>,May you have a GOOD DAY!</div>
    </div>
    <script>
        window.addEventListener('load', function() {
            // Add the 'fade-in' class after a brief delay to trigger the transition
            setTimeout(function() {
                document.getElementById('top').classList.add('fade-in');
            }, 100); // Adjust the delay as needed
        });
    </script>
</div>
<!-- Main content -->
<div class="container" id="container" style="display: none;">
    <!-- Left content -->
    <div id="left-container" class="left-container">
        <div id="controls">
            <button id="startButton">Start Camera</button>
            <button id="stopButton">Stop Camera</button>
        </div>
        <video id="video" width="750" height="450" autoplay muted></video>
        <div id="bottom-controls" class="bottom-controls">
            <button id="saveButton">Save Result</button>
            <button id="changeButton" onclick=jump("./index_1.jsp")>Original Version </button>
            <script>
                function jump(target) {
                    window.location.href = target;
                }
            </script>
        </div>
    </div>
    </div>

</div>

</body>
</html>
