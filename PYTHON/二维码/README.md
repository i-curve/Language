Python二维码:

​	是把字符信息和图片信息相互转换的方法

# 二维码生成: qrcode包

pip install qrcode

```python
import qrcode
'''
法1:
'''
img = qrcode.make('hello,world!')
img.get_image().show()
'''
法2:
'''
qr = qrcode.QRcode()
qr.add_data('hello,world!')
qr.make()
img = qr.make_image()
img.show()
```



# 二维码的解析: pyzbar

pip install pyzbar

```python
import os
from io import BytesIO
from pyzbar import pyzbar
from PIL import Image

def fun(img_adds):
	if os.path.isfile(img_adds):
		img = Image.open(img_adds)
	else:
		print('出错')
	img.show()
	sleep(2)
	txt_list = pyzbar.decode(img)
	for txt in txt_list:
		barcodeData = txt.data.decode('utf-8')
		print(barcodeData)
if __name__ == '__main__':
    '''路径path'''
	fun('./m.png')

```

