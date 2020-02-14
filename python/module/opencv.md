图像处理库

**图像的处理：**

读写：

cv2.imread('name')

cv2.imshow('windows',img)

图像的编码以及解码：

（cv2.imencode)编码是把，内存中的数据转换成可以直接在网络上传输的数据流

参数：文件名、格式

（cv2.imdecode)解码是把，数据流转换为可显示的格式

参数：格式、文件名

**视频的处理：**

读写：

video=cv2.VedioCapture("name")  <font size=2>注：当传入的是整数是，将从相应的设备进行读取</font>

vide0.get() :获取视频的相应属性均为cv2.CAP_PROP_开头

bool，frame=video.read()将读取一帧图像，读取完自动加一

.set() :设置帧的位置