#### 内存管理
RTTI Run Time Type Identification 运行时类型识别
    typeid和dynamic_cast

RAII（Resource Acquisition In Initialization） 资源获取即初始化

迭代器如何设计

#### 2024

- install perf first
~~~
perf record -o my_trace.data <your-command-or-program>
timestamp=$(date +"%Y%m%d%H%M%S")
perf script -i my_trace.data | stackcollapse-perf.pl | flamegraph.pl > ../${timestamp}.svg
~~~
