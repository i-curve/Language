### vue配置文件
&nbsp;  
[copy位置](#x)
配置的文件名:  vue.config.js
```js
module.exports = {
    devServer: {
        // 关闭报错
        overlay: {
            warning: false,// 相应的警告
            error: false //报错信息
        },
        // 配置跨域
        proxy: {
            "/api": {
                target: "https://api.jisuapi.com/miyu/search",
                changeOrigin: true,
                ws: false,
                secure: false,
                pathRewrite: {
                    "/api": ""
                }
            }
        }
    },
    // 关闭报错
    lintOnSave: false,
    // 公共路径
    publicPath: './',
	assetsDir: "assets",
    productionSourceMap: false,
    // 输出目录
	outputDir: 'dist'
}
```


<span id="x">**<bold>正式文件</bold>**</span>
<font color="red">vue.config.js</font>
```js
module.exports = {
    devServer: {
        overlay: {
            warning: false,
            error: false
        },
        proxy: {
            "/api": {
                target: "https://api.jisuapi.com/miyu/search",
                changeOrigin: true,
                ws: false,
                secure: false,
                pathRewrite: {
                    "/api": ""
                }
            }
        }
    },
    lintOnSave: false,
    publicPath: './',
	assetsDir: "assets",
	productionSourceMap: false,
	outputDir: 'dist'
}
```