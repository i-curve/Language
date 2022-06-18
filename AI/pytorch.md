# pytorch 模型需要的步骤:

## 1. 模型的构建

```py
class Net(nn.Module):

​ '''需要完成 forward 函数,模型的传递

​ '''

​ def \_\_init\_\_(self,):

​ super(Net,self).\_\_init\_\_()

​ def \_\_forward\_\_(self,x):

```

## 2. 数据集的构建

```py

class Dataset(Dataset):

需要实现 getitem 方法,即下标的方法

​ <font color=red>要在这里把 getitem 返回的数据集转换成 Tensor()格式</font>

​ '''

​ def \_\_init\_\_(self,data, transforms=transform<font size=2>**_数据转换_**</font>):

​ def \_\_getitem\_\_(self,idx):
```

## 3. 构建损失函数

```py

loss = nn.MSELoss()

optimizer = optim.SGD(net.parameters(),lr=0.01) <font size=2>**_keras 默认的学习率为 0.01_**</font>
```

## 4. 通过模型迭代处理数据集并更新梯度
