
### Chapter 2.
#### 模型概述
- Many-to-One和Many-to-Many
- Releational Database Model and Document Database
- JSON Model
- Network Model
	CODASYL
- Graph-Like Data Model

#### 数据库
New SQL
Google Spanner

allow for locality in relational database
Why is relational model meeting difficulties?
	imperative database is hard to be digged for performance optimization.

#### 查询语言
	MapReduce 计算Language
	非声明式也非 命令式imperative 查询语言
	NoSQL可能重新发明了查询语句

### Graph Models
#### Property Graphs
road and rail networks

- Cypher Language
- SPARQL
    应用于RDF数据,三种基本语义网络技术之一

#### 图数据库不等于网络模型

#### Other Models
	Gen Models


### Chapter 3. Storage and Retrieval
哈希索引的两种实现方式
日志文件格式的数据库方式
	compaction:去除key
	crash恢复
		bitcask
	SSTable和LSM-Tree
	效率,写放大
	LevelDB和RocksDB,Canssandra
B-Tree索引
B+树索引


聚簇索引是什么
非聚簇索引是什么

MongoDB


Bitcask
