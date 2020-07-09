#### React

module.exports
    require
/\.jsx?$/
return () vs return {} ?

items.map(function (item, i) {
    return <li key={i}>{item}{/li}
})
const ReactDOM = require('react-dom');

~~~js
ReactDOM.render(<HelloWorld/>, document.getElementById('main'));
~~~

- 怎么封装一个组件
refs render setState state
props

参考学习链接
	实验楼入门:
	https://www.shiyanlou.com/courses/1275/learning/?id=10323

Chapter 2
	在本节中，我们学习了ES6语法的以下内容:
	let & const
	箭头函数
	类
	模板字符串

Chapter 3
	JSX
	JSX 的全称是 JavaScript XML，它是一种 JavaScrip 的语法扩展，也就是一种语法，在 React 中我们不一定要使用 JSX，但使用 JSX 有以下优点. --略

ES6 迁移	
	JSX 绑定事件与原生 HTML 差别并不是很大，唯一的却别就是 JSX 采用驼峰(camelCase)命名法来描述事件的名称，例如：

Chapter 5
	组件
函数式声明
~~~javascript
	function Welcome(props) {
		return (
		<div>Hello world(props.name}</div>
		)
	}


	//类声明(定义) ES6
	class Welcome extends React.Component{
		render(){
			return(
				<div>
					<h1>Hello,{this.props.name}</h1>
					<h2>Have a nice time!</h2>
				</div>
			);
		}
	}
~~~
无状态组件
~~~
const Welcome = props => {
    return(
        <div>
            <h1>Hello,{props.name}</h1>
            <h2>Have a nice time!</h2>
        </div>
    );
}
~~~

props和state的区别

高级话题
	V8引擎
	前端parser

