**常用的创建方法:**

np.linspace(), np.arange()

np.zeros(), np.ones(),np.empty()

**基本属性,方法:**

.shape, .dtype,.ndim

.reshape(),  

**数组的运算:**

concatenate((a,b),axis=0):数组连接,数组轴必须已有

vstack():0轴

hstack():1轴

.transpose():重新设置轴的顺序

.dot():矩阵乘积   .inner():内积   .outter():外积

**数组的广播:**

 	确定shape,补充

1. 让所有的数组都向维数最多的数组看齐
2. 输出数组的shape属性是输入数组各个轴上最大值
3. 从低维到高维填充

**一些函数库:**

np.random:随机数库

np.str:字符串库

**自身库:**

np.sum(),np.average(),np.min(),mp.max(),np.median()

np.mean(),np.var(),np.std(),np.ptp()

np.where(con,y,z)