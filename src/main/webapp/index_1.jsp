<%--
  Created by IntelliJ IDEA.
  User: 30407
  Date: 2024/6/23
  Time: 21:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link rel="icon" href="img/logo.ico" type="image/x-icon">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Real-Time Face Emotion Detection</title>
  <script defer src="./js/face-api.min.js"></script>
  <script defer src="./js/script.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
  <link rel="stylesheet" href="./css/style.css">
</head>
<body>

<!-- Load animation -->
<div class="loading" id="loading">
  <span>Loading models && database</span>
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
      <input type="file" id="fileInput" accept="image/*,video/*" style="display:none;">
      <button id="uploadButton">Upload</button>
      <button id="clearButton">Clear</button>
      <button id="startButton">Start Camera</button>
      <button id="stopButton">Stop Camera</button>
    </div>
    <a id="remind">上传时请选择jpg/png/mp3等格式文件。</a>
    <video id="video" width="560" height="480" autoplay muted></video>
    <div id="bottom-controls" class="bottom-controls">
      <button id="saveButton">Save Result</button>
      <button id="capture">Capture</button>
      <button id="changeButton" onclick=jump("./index_2_FV.jsp")>Faster Version </button>
      <script>
        function jump(target) {
          window.location.href = target;
        }
      </script>
    </div>
  </div>

  <!-- Right content -->
  <div id="right-container" class="right-container">
    <div class="emotions"></div>
  </div>

  <div id="data-container" class="data-container">
    <div class="data">
      <a style="color: white;font-family: 微软雅黑, sans-serif;text-align: center"><strong>▶capture data◀</strong></a>
    </div>
  </div>
</div>

</body>

<%--<script>--%>
<%--  document.addEventListener('DOMContentLoaded', () => {--%>
<%--    const fileInput = document.getElementById('fileInput');--%>
<%--    const uploadButton = document.getElementById('uploadButton');--%>
<%--    const clearButton = document.getElementById('clearButton');--%>
<%--    const video = document.getElementById('video');--%>

<%--    // document.body.appendChild(fileInput);--%>

<%--    // Handle the upload button click--%>
<%--    uploadButton.addEventListener('click', () => {--%>
<%--      fileInput.click();--%>
<%--    });--%>

<%--    // Handle file input change (file selection)--%>
<%--    fileInput.addEventListener('change', (event) => {--%>
<%--      const file = event.target.files[0];--%>
<%--      if (file) {--%>
<%--        const url = URL.createObjectURL(file);--%>

<%--        if (file.type.startsWith('image/')) {--%>
<%--          video.style.backgroundImage = `url(${url})`;--%>
<%--          video.style.backgroundSize = 'cover';--%>
<%--          video.style.backgroundPosition = 'center';--%>
<%--          video.src = ''; // Clear any existing video source--%>
<%--        } else if (file.type.startsWith('video/')) {--%>
<%--          video.style.backgroundImage = ''; // Clear any existing background image--%>
<%--          video.src = url;--%>
<%--          video.play();--%>
<%--        }--%>
<%--      }--%>
<%--    });--%>

<%--    // Handle the clear button click--%>
<%--    clearButton.addEventListener('click', () => {--%>
<%--      video.style.backgroundImage = '';--%>
<%--      video.src = '';--%>
<%--    });--%>
<%--  });--%>
<%--</script>--%>
</html>
