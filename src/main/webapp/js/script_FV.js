
const video = document.getElementById('video');
const startButton = document.getElementById('startButton');
const stopButton = document.getElementById('stopButton');
const saveButton = document.getElementById('saveButton');  //保存网页内容
// const changeButton = document.getElementById('changeButton');  //切换版本按钮

let stream = null;
let canvas = null;
let fasterVersion = true; // 初始化为 false，即默认是完整版本

Promise.all([ //idea配置路径！！
    faceapi.nets.tinyFaceDetector.loadFromUri('../web_demo_war/models'),
    faceapi.nets.ssdMobilenetv1.loadFromUri('../web_demo_war/models'),
    faceapi.nets.mtcnn.loadFromUri('../web_demo_war/models'),
    faceapi.nets.faceLandmark68Net.loadFromUri('../web_demo_war/models'),
    faceapi.nets.faceRecognitionNet.loadFromUri('../web_demo_war/models'),
    faceapi.nets.faceExpressionNet.loadFromUri('../web_demo_war/models'),
]).then(loadPersons).then(() => {
    startButton.addEventListener('click', startVideo);
    stopButton.addEventListener('click', stopVideo);
    saveButton.addEventListener('click', saveWeb);
    // changeButton.addEventListener('click', toggleVersion); // 添加切换版本的事件监听器
});

async function loadPersons() {
    document.getElementById('loading').style.display = 'flex'; // 显示加载动画
    const labeledFaceDescriptors = await loadLabeledImages();
    faceMatcher = new faceapi.FaceMatcher(labeledFaceDescriptors, 0.6);
    document.getElementById('loading').style.display = 'none'; // 隐藏加载动画
    document.getElementById('container').style.display = 'flex'; // 显示页面内容

}

function startVideo() {
    navigator.getUserMedia(
        { video: {} },
        function(localStream) {
            stream = localStream;
            video.srcObject = stream;
        },
        err => console.error(err)
    );

    clearAllCanvases();
}
function stopVideo() {
    if (stream) {
        stream.getTracks().forEach(track => track.stop());
        video.srcObject = null;
    }
    clearAllCanvases();
}
function clearAllCanvases() {
    const canvases = document.querySelectorAll('canvas');
    canvases.forEach(canvas => {
        const context = canvas.getContext('2d', { willReadFrequently: true });
        context.clearRect(0, 0, canvas.width, canvas.height);
        canvas.remove();
    });
}
function saveWeb(){
    // html2canvas(document.body).then(canvas => {
    //     canvas.toBlob(blob => {
    //         saveAs(blob, 'screenshot.png');
    //     });
    // });

    html2canvas(document.body).then(function(canvas) {
        // 创建一个链接元素
        const link = document.createElement('a');

        // 将canvas转换成Data URL
        link.href = canvas.toDataURL('image/png');

        // 设置下载文件的名字
        link.download = 'emotion.png';

        // 触发下载
        link.click();
    });
}

// function toggleVersion() {
//     fasterVersion = !fasterVersion; // 切换版本状态
//     if (fasterVersion) {
//         changeButton.textContent = 'Lower Version';
//         changeButton.style.backgroundColor = '#f44336';
//     } else {
//         changeButton.textContent = 'Faster Version';
//         changeButton.style.backgroundColor = '#8A2BE2';
//     }
// }



video.addEventListener('play', () => {
    canvas = faceapi.createCanvasFromMedia(video);
    video.parentElement.append(canvas); // 将 canvas 放置在 video 的父元素中，使其重叠
    const displaySize = { width: video.width, height: video.height };
    faceapi.matchDimensions(canvas, displaySize);

    // 开始处理视频
    processVideo();

    // setInterval(async () => {
    async function processVideo() {
        // //清空所有canvas
        // clearAllCanvases()
        // //检测人脸结果【后续如果已检测，则不绘制 (人名输出为unknown且右侧不输出结果)】
        // let detectedNames = {};


        if (fasterVersion) {  //当选用faserVersion，则仅进行左侧情绪识别
            // // 仅进行情绪识别
            // clearAllCanvases()
            //清空右侧情绪情况
            // const emotionsContainer = document.querySelector('.emotions'); // 获取情绪容器的引用
            // emotionsContainer.innerHTML = ''; // 清空现有的情绪变化条

            const detections = await faceapi.detectAllFaces(video, new faceapi.SsdMobilenetv1Options()).withFaceExpressions();
            const resizedDetections = faceapi.resizeResults(detections, displaySize);
            canvas.getContext('2d', {willReadFrequently: true}).clearRect(0, 0, canvas.width, canvas.height);
            faceapi.draw.drawDetections(canvas, resizedDetections);
            faceapi.draw.drawFaceExpressions(canvas, resizedDetections);
        } else {
            //清空右侧情绪情况
            const emotionsContainer = document.querySelector('.emotions'); // 获取情绪容器的引用
            emotionsContainer.innerHTML = ''; // 清空现有的情绪变化条

            //捕获视频流中的某一帧 并 获取描述符/检测结果
            const descriptor_detections = await faceapi.detectAllFaces(video, new faceapi.SsdMobilenetv1Options()).withFaceLandmarks().withFaceDescriptors();
            const detections = await faceapi.detectAllFaces(video, new faceapi.SsdMobilenetv1Options()).withFaceExpressions();
            const descriptor_resizedDetections = faceapi.resizeResults(descriptor_detections, displaySize);
            const resizedDetections = faceapi.resizeResults(detections, displaySize);

            // if(descriptor_resizedDetections.length !== resizedDetections.length)
            //     console.log('descriptor_resizedDetections: ', descriptor_resizedDetections)
            //     console.log('resizedDetections: ', resizedDetections)

            canvas.getContext('2d', {willReadFrequently: true}).clearRect(0, 0, canvas.width, canvas.height);
            faceapi.draw.drawDetections(canvas, resizedDetections);
            faceapi.draw.drawFaceExpressions(canvas, resizedDetections);

            let results = descriptor_resizedDetections.map(d => faceMatcher.findBestMatch(d.descriptor));
            console.log(results)
            // console.log(results._label)

            //处理results(对于重复的结果，选取与database中图像distance最小的作为result，其余设置为 未知)
            // 第一步：找到每个 label 的最小 distance
            const minDistanceMap = {};

            results.forEach(item => {
                const label = item._label;
                const distance = item._distance;

                if (!minDistanceMap[label] || distance < minDistanceMap[label]) {
                    minDistanceMap[label] = distance;
                }
            });
            // 第二步：更新 data 数组中大于最小 distance 的 label
            // let unknownCounter = 1;
            results.forEach(item => {
                const label = item._label;
                if (label === 'unknown') {
                    item._label = '未知';
                }
                const distance = item._distance;

                if (distance > minDistanceMap[label]) {
                    item._label = '未知';
                    // item._label = `未知${unknownCounter}`;
                    // unknownCounter++;
                }
            });

            results.forEach((result, i) => {
                console.log(result)
                console.log(i)

                //保证框的结果是一一对应的
                var box;
                if (resizedDetections.length > i) {
                    box = resizedDetections[i].detection.box;
                    // console.log('XXXX')
                } else {
                    box = descriptor_resizedDetections[i].detection.box;
                }

                //计算视频中人脸特征和最佳匹配人脸之间的距离，而后用1-distance得到有多大概率相同
                const drawBox = new faceapi.draw.DrawTextField(result.label + '(' + (1 - result.distance).toFixed(2) + ')', box.topRight, {
                    anchorPosition: 'TOP_Right',
                    backgroundColor: 'rgba(0, 0, 0, 0.5)'
                });
                drawBox.draw(canvas);


                //添加人物情绪
                if (resizedDetections[i] === undefined) {
                    return;
                }
                const emotions = resizedDetections[i].expressions;  //所有情绪
                // console.log(emotions)
                const dominantEmotion = getDominantEmotion(emotions);  //主要情绪
                const personEmotionsDiv = document.createElement('div');
                personEmotionsDiv.className = 'person-emotions';


                // 创建并添加姓名和性别元素
                const nameDiv = document.createElement('div');
                nameDiv.className = 'name';

                nameDiv.textContent = result.label; // 姓名

                // 创建并添加代表最有可能情绪的照片和文字
                const dominantEmotionDiv = document.createElement('div');
                dominantEmotionDiv.className = 'dominant-emotion';

                // 添加情绪文字元素
                const emotionText = document.createElement('span');
                emotionText.className = `emotion-label ${dominantEmotion}`
                emotionText.textContent = dominantEmotion.charAt(0).toUpperCase() + dominantEmotion.slice(1);
                dominantEmotionDiv.appendChild(emotionText);

                // 添加情绪图片元素
                const emotionImg = document.createElement('img');
                // emotionImg.src = `images/${dominantEmotion}.png`; // 假设有相应的情绪图片
                emotionImg.src = `./emotions_images/${dominantEmotion}.png`; // 假设有相应的情绪图片
                emotionImg.alt = dominantEmotion;
                dominantEmotionDiv.appendChild(emotionImg);


                // //添加所有的
                // personEmotionsDiv.appendChild(dominantEmotionDiv);
                personEmotionsDiv.appendChild(nameDiv);
                personEmotionsDiv.appendChild(dominantEmotionDiv);
                // personEmotionsDiv.appendChild(genderDiv);

                for (const emotion in emotions) {
                    if (emotions.hasOwnProperty(emotion)) {
                        // console.log(`${emotion}: ${emotions[emotion]}`);
                        //
                        // console.log(emotion)

                        const emotionDiv = document.createElement('div');
                        emotionDiv.className = 'emotion';

                        const label = document.createElement('span');
                        label.className = `emotion-label ${emotion}`;
                        label.textContent = emotion.charAt(0).toUpperCase() + emotion.slice(1); // 首字母大写

                        const progress = document.createElement('progress');
                        progress.id = `${emotion}-${i}`;
                        progress.max = '1';
                        progress.value = emotions[emotion];

                        emotionDiv.appendChild(label);
                        emotionDiv.appendChild(progress);
                        personEmotionsDiv.appendChild(emotionDiv);
                    }
                }

                emotionsContainer.appendChild(personEmotionsDiv);


            });
        }

        // 根据fasterVersion值设置下一次执行的间隔
        const interval = 100;
        setTimeout(processVideo, interval);

    }
    // }, 1000);


});

async function loadLabeledImages() {
    // const labels = ['zbl', 'zyz', 'lhq'];
    const labels = ['zbl', 'zyz', 'lhq', 'sjh'];

    return Promise.all(
        labels.map(async label => {
            const descriptions = [];
            for (let i = 1; i <= 1; ++i) {
                const img = await faceapi.fetchImage(`./persons/${label}/${i}.jpg`);
                const detections = await faceapi.detectSingleFace(img).withFaceLandmarks().withFaceDescriptor();
                descriptions.push(detections.descriptor);
            }
            return new faceapi.LabeledFaceDescriptors(label, descriptions);
        })
    );
}

function getDominantEmotion(emotions) {
    let dominantEmotion = null;
    let maxEmotionValue = -1;
    for (const emotion in emotions) {
        if (emotions[emotion] > maxEmotionValue) {
            maxEmotionValue = emotions[emotion];
            dominantEmotion = emotion;
        }
    }
    return dominantEmotion;
}
