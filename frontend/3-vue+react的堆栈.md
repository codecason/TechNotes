
#### 调试template渲染时候的代码
方法

https://vuedose.tips/debugging-templates-in-vue-js/

This is due that everything that you placed in the template Vue try to find it in the instance so a quick solution could be put a log method in the component to allow Vue to find it: 在组件中添加方法
~~~js
methods: {
    log(message): console.log(message);
}

// 在template中实现
{{ log(message) }}
~~~

如果要在多个组件中实现这一个方法,
则覆盖main.js里的方法:
1. 
~~~js
Vue.prototype.$log = console.log;
~~~
2.
~~~
{{ $log() }}
~~~

#### 打印堆栈

