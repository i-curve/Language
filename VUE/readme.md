### Vue3.0学习

文档官网: [v3.vuejs.org](v3.vuejs.org)

1. vue中的$refs  
父组件中访问子组件中的属性。  
ref放到组件上获取到的就是组件的实例,如果放到元素上,那么就是元素.
```
<templete>
<div>
<Father ref = "名字">
</div>
</templete>
<script>
export default {
    name: 'app',
    setup () {
        const 名字 = ref(null)
        console.log(this.$refs.名字)//可以调用子组件中的信息
    }
}
</scripy>
```