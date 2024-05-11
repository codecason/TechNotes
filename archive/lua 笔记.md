	3. string
		b = string.gsub(a, "one", "another")
	-- todo
	string 与numbers之间自动转换
	e.g. 
	符号: ..是连接符
	print(10 .. 20) => out: 1020

4. function

5. userdata and threads

语法
2. 运算符
	binary:+ - * ^
	unary: -
	<= >= == ~=
	e.g. C: a ? b : c <=> lua: (a and b) or c

## 数据结构
> table
	opnames = {["+"] = "add", ["-"] = "sub"}
	table混合了数组和字典;数组下标**从1开始**
	arr = {1, 2, 3} => print(arr[1]) out: 1
	e.g. 混合
		arr = {["+"] = 12, ["-"] = -1, 12, 13}
		print(arr[2]) #13
	嵌套
		arr = {color="b", {x = 0, y = 1}}
	插入
	table.insert(tableobj, obj)
	e.g. x = {}; table.insert(x, "2")
	遍历
		for i, j in pairs(x)
>
	集合Set: set = {}; set[x] = true, set[y] = true #无视true但是它要在set中
	映射Map: 就是Table
	数组Array: arr[1] = 2

> 弱表
	weak table

> 闭包 upvalue


## 程序设计
	赋值, block, chunk
1.循环
	e.g. for i=st,ed,step do ...... end
	pairs, ipairs 函数
	for k, v in pairs(t)
		pairs函数返回 iter, t, nil
	for k, v in ipairs(t)
		sleep
		source
		tcp6
		_SETSIZE
		_VERSION
		connect
		sink
		__unload
		connect6
		_DEBUG
		skip
		BLOCKSIZE
		dns
		gettime
		udp
		sinkt
		sourcet
		choose
		try
		tcp
		bind
		connect4
		protect
		select
		newtry
		udp6
		>

2.函数
	2.1 参数
	function (arg1, ...)
	# ...在函数中用arg表示,取值如arg[1]

	2.2 函数闭包
	lambda函数跟js类似
	支持成员声明语法:
	Lib = {}
	function Lib.foo(x, y)
		return x + y
	end
	2.3 
	尾调用
		可以不用保存当前函数栈的调用
	通常情况下，迭代函数都难写易用。这不是一个大问题：一般Lua编程不需要自己
定义迭代函数，而是使用语言提供的,除非确实需要自己定义。
local path = "/usr/local/lua/lib/libluasocket.so"
local f = loadlib(path, "luaopen_socket") 
	2.4
	e.g. f = loadstring("-- statement...")
	loadstring 返回内容为statement的函数
	dofile()
	require()
	require better than: dofile
	
	2.5 linux 动态链接
	local path="/usr/local/lua/lib/xx.so'
	
	2.6 错误处理
	error()
	debug.traceback()

	2.7
	dispatcher 分配器

>> 2. 变量
	_G / environment; _G.f, _G["f"]
	rawset(_G, name, value) -- 声明一个变量
	关于环境,lua的行为令人难以捉摸,可以修改全局变量保存的table,也可以用来隔离不同的环境

3.
	类成员: [类名:函数名]
		e.g. c:connect
	Ch13 metatable
	Set = {}; Set.mt = {}
	设置定一个类的metatable, setmetatable(Set, Set.mt)
		一个table的保留操作(如+, -)会调用该类的metatable的meta函数
		number = {}; number.__eq, number.__lt, number.__add, number.__mul
		__index, __newindex
		tostring

>> 4. 成员函数
	冒号,点号语法,表示加入了一个self参数到变量里,一般来说定义和调用要用同一个标点
	a:deposit(100) <=> a.deposit(a, 100), :是点号的语法糖

>> 5. 继承
	改写父类的new方法
	
## 操作系统

####
>> 1. io 读取
	io.read()
	os.rename(oldfilename, newfilename)
	字符串连接
		跟Java一样的问题,要用table.concat重写 a .. b 才能提高效率

>> 2. package
	


## 协程
	Example (Ch9)
		调用
		dispatcher(), create协程, resume->download函数->包含了receive->socket

## 垃圾回收

## 标准库
	table: insert sort getn
	string: gsub sub find rep format(pattern, string.byte)
	io: input open(filename, "r")
	os: date rename setlocale getenv execute(important!)
	debug: getinfo

## C-API
	<lua.h>
	<luaxlib.h>
	<lualib.h>
	lua_open
	lua_pcall
	lua_pushnil(lua_State* L)
	lua_pushboolean(lua_State*L, bool);
	lua_istring
	lua_insert
	lua_rawset
	luaL_checktype

安装	sudo apt-get install liblua5.2-dev

	编译 gcc -I luapath -o target main.c -llua5.x
	where luapath is the dir of lua.h

## 错误处理
	C与Lua的互相调用
		C函数注册

## lua references
	references系统

	luaL_ref // 在C程序中得到ref的值
	luaL_unref // 取消ref

## 用户定义类型
	lua_newuserdata
	light userdata


# References
代码测试
http://www.dooccn.com/lua/
