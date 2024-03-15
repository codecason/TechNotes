#### 1.9 Important Themes

- Concurrency and Parrallesim
Hyperthreading, sometimes calledsimultaneous multi-threading, is a technique that allows a single CPU to execute multiple flows of control.

Thread-Level Concurrency: multi-core
Instruction-Level Concurrency: pipeline
SIMD Concurrency:special IO hardware

A pipeline can overlap phases the execution of an instruction with previous instructions.[1]
Three controls hazards: Read after write(RAW, so are the next), WAW, WAR
[1] http://www.cse.unsw.edu.au/~cs9244/06/seminars/01-gvdl.pdf

- Abstractions for computers
    files
	process
	virtual memory
	virtual machine
	
#### 1.10 Summary

### CH2. Representing and Manipulating Information
- data storage
gcc -m32 prog.c
gcc -m64 prog.c
Later in other chapters: disassembler
- you can show ascii table in shell: man ascii
Data Types
	Integer Representations

- Floating Point


#### CH 4 Processor Architecture

RISC处理器
CPU
	arm mips
硬件支持
	Logic Gates
	multiplexor
	register file
	memory
#### 4.3 Sequential Y86-64 Implementation
SEQ流程,但不是每个指令都需要走所有步骤
	1.Fetch
	2.Decode
	3.Execute
	4.Memory
	5.Write back
	6.PC Update
	解析单指令,trace其过程的语法:
		icode:ifunc M1[PC],
		其中icode:ifunc是一个字节;M1的下标1表示取一个字节
		valA,valB,valC,valM:对应register file的端口
		PC:对应一个寄存器
	SEQ
	SEQ+
概念:
    ISA: Industrial Standard Architecture，工业标准结构总线
    Intel指令集
    RISC:reduced instruction set computer. Embedd devices.
    CISC:complex instruction set computer.
    ARM: originally an acronym for "Acorn RISC machine". A British company, Acorn Computers Ltd., developed its own architecture, ARM

~~~
    为了研究处理器的架构, CSAPP设计了一套简化的计算机模型和对应的指令集叫做Y86-64. 主要特点如下:

    15个寄存器, 不包括%r15. 这样内部寻址可以用0-15来选择寄存器. %rsp依然用作栈指针
    每个寄存器都报保存64位=8字节值, 机器里操作的所有值也都是8字节长
    三个一位的条件码: ZF SF 和 OF
    程序计数器 PC
    有一个状态码 Stat 用于表示程序状态
    DMEM 内存, 这里把内存当成一个连续的虚拟内存, 内存使用基址+偏移量方式寻找, 不支持复杂的寻址运算, 其实就相当于直接用固定基础地址寻址.
    [柚子小站](https://conyli.cc/archives/2926)
~~~

![CPU flow](fig1.png)
![CPU flow](fig2.png)

- HCL
- Y86-64指令:
  - irmovq
  - rrmovq
  - r代表寄存器
  - i立即数
  - m内存

~~~
4.5.4 Next PC Prediction
~~~
- in one case, value read can be speeded up due to less steps for reading.
- Pipelined execution of using stalls.

1. in some cases, data hazards can unfortunately happen when some program states will be updated and read after some instructions.

2. avoiding hazards by forwarding: send values directly.

3. solve branch prediction error: by add bubble(nop instruction) to stages.

~~~
 4.5.6 Exception handling
~~~
CPI(Cycle Per Instruction)
=1.0+load penalty+mispredicted branch penalty+return penalty


~~~
Multicycle Instructions
~~~

#### CH 5 Optimizing Program Performance

Cycles Per Element: CPE
to express program performance in iterative programs.

5.10
Latency,issue times,capacities

unrolling a loop(Mark: deprecated).

program profiling

Amdahl's law

algorithm and data should remain a primary concern in programmers(comparing to compiler optimization and some tricks.)
