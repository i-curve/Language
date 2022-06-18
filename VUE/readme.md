# Vue3.0 学习

## 数据响应式:ref,reactive

一般是使用 ref 给单个数据做响应式,relative 给复合数据做响应式。

1. 获取具体的值： ref 后加.value, relative 后直接用

```js
setup () {
    const a = ref("name")
    const b = reactive({
        c:123,
        d:"xixiaha"
    })
    console.log(a.value)
    console.log(b.c)
}
```

2. 父组件中访问子组件中的属性。  
   ref 放到组件上获取到的就是组件的实例,如果放到元素上,那么就是元素.

- 组件中使用

```javascript
<template>
home &nbsp;
  <child ref="father"/>
  <button @click="changeName">father</button>
</template>

<script>
import Child from './Child.vue'
import { ref } from 'vue'
export default {
  name: 'HomePage',
  components: {
    Child
  },
  setup () {
    const father = ref(null)
    const changeName = () => {
      father.value.change()
    }
    return {
      father,
      changeName
    }
  }
}
</script>

```

- 元素中使用

```js
<template>
    <div ref="test">child</div>
    <button @click="change">button</button>
</template>
<script>
import { ref } from 'vue'
export default {
    name: "ChildPage",
    setup () {
        const test = ref(null)
        const change = () => {
            console.log(test.value.innerHTML)
        }
        return {
            test,
            change
        }
  }
}
</script>
```

3. ref 的周边

toRef 把相应数据转换为 ref
ifRef 判断是否是 ref
toRefs 把对象中所有子类转换为响应式

## setup 学习

vue3 中处了 components 和 props 只外,其他所有的内容都应该写到 setup 中.

- 参数:
  setup (props, ctx)
  第一个参数: 是该组件中获取的参数,已经是响应式的内容了,不应该对其进行解构,如果解构的话会丧失响应式.
  第二个参数: 有三个部分组成 attrs，emit，solt

- ctx 解构的 attrs 和选项 api 中 props 是一样的，但是 props 可以明确指定数据类型

```js
export define {
    name: "app",
    props: {
    },
    emit: ['add'],
    setup (props, ctx) {
        // 如果用了选项props,那么这里的prop就不会有内容了
        // emit 是调用其他组件组件中的函数。这里的话就说明add函数一定在其他组件用有定义，并且被return到了dom中。
        ctx.emit('add',123)
        // 打印获取的数据,是响应式的
        console.log(ctx.attrs)
    }
}
```

## 计算属性

用于手动该变一些内容到指定的值

返回 store 中的数据

```js
setup () {

    return {
        reason: computed(()=>store.state.reason)
    }
}
```

## wathe 监听函数

用于监听某个值的变化,并做出相应的逻辑操作,有两个回调函数。也是写在 setup 中

```js
// 可以监听多个值,此时使用数组指明数据
watch(
  () => {
    return value;
  },
  (newValue, oldValue) => {}
);
```

```js
watch(
    get(){
        //值变化时候执行的操作
    },
    set(){
        //设置值的时候执行的操作
    }
)
```

## 数据注入: provide/inject

privide(数据名,数据值)
inject(数据名,数据类型,默认值)

- **provide 不但能提供数据,还能提供方法**

```js
// 提供方
export default {
    setup () {
        provide("name","张三")
        provide("age",21)
    }
}

// 接收方
export default {
    setup () {
        inject("name",string,"a")
        inject("age",number,0)
        return {
            name,
            age
        }
    }
}
```

## Store 存储数据的修改

调用流程

: 组件 -> action -> mutation -> state -> 视图变更

1. 组件 -> dispatch -> action
2. dispatch -> type(actionType) -> 某一个 action
3. action -> commit 调用 -> mutation
4. mutation -> change -> state
5. render 方案: state -> 数据流 -> 视图
