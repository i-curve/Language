### node配置  

&nbsp;  
**相关的文件:**
package.json: 整个项目包管理名单,控制整个项目所需要的相关包。
package-lock.json: 锁定版本号
node_modules: 安装的包所在的文件夹


```js
npm install *** -g: 全部安装命令
npm install *** --save-dev: 开发包依赖
npm install *** -S: 默认为正式版本依赖
```
命令大全
```js
# 1.安装命令  -g为全局安装,默认本地安装
npm install packageName -g
# 2.卸载命令
npm uninstall packageName
# 3.查看包
npm ls
# 4.更新包
npm update packageName
# 5.查找包
npm search packageName
# 6.查看包信息
npm info packageName
```