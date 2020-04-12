
### Chapter 2.
#### 模型概述
- Many-to-One和Many-to-Many
- Releational Database Model and Document Database
- JSON Model
- Network Model
	CODASYL
    Make querying and updating the database inflexible.
- The Relational Model

- Graph-Like Data Model
  - Social graphs
  - The web graph

- Triple-Stores and SPARQL
  - SPARQL
  - Gremlin (Graph query language)

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
#### Database Structure
哈希索引的两种实现方式
日志文件格式的数据库方式
	compaction:去除key
    	crash恢复 bitcask
	SSTable和LSM-Tree
    	效率,写放大
	LevelDB和RocksDB,Canssandra

####　Transaction Processing or Analysis
-   Data Warehousing
    In-memory Relation Model Database
    Extract-Transform-Load ETL
    Open Source Data Warehousing:
        Spark SQL
        Facebook Presto
        Impala
    Commercial Data Warehouse:
        Teradata
        Vertica
        SAP HANA
-   Features
        Stars and Snowflakes
-   Column-Oriented Storage
    The difference of Column Database and Document Database
        列数据库跟文档数据库的区别

-   SIMD for CPU bandwidth optimization

B-树 Index
B+树 Index
    update-in-place policy
Bitmap Index

聚簇索引是什么
非聚簇索引是什么

MongoDB

Bitcask

### Chapter 4. Encoding and Evolution
#### Formats for Encoding Data
    Client Side Apps Upgrade

- Code generation and Dynamically Typed Language
    Tip: 不加tag(字段序号)的数据编码类型跟动态类型语言有什么关系?
    动态类型语言常常不需要代码生成
- Dataflow through services: rpc and REST
    REST和RPC服务
    REST不是协议,而是HTTP协议规范
    RPC is built on top of REST.
    Futures,or promises,are used to deal with async requests.
    The reason of using rpc:
- Message Broker(Message Queue)
    The reason to use
  - Actor Model framework samples to handle upgrade rolling

## Part II.Distributed Data
### Chapter 5. Replication
    Replication Log
        Eventual Consistency
    
Q: Multi-Leader Replication
    Collaborative Editing
Q: Concurrency conflict resolving

    Multi-leader Replication Topology

- Leaderless Replication
Q: Why is it necessary to detect staleness?
A: To quantify the consistency of the system.
    Limitations of quorum consistency.

- Multicenter Datacenters
Q: what will happen if we use the last write wins policy?
A: It will make it misleading to the clients.

- Write Combing
Q: What is a tombstone in distributed system?
A: A marker used for mark deletion.

### Chapter 6. Partition
- Partition of Key-Value Data
    Partition by Key Range
    Partition by Hash of Key
    Skewed Workloads
Q: What's the implementation for solving key skewed?
A: TODO.

- Rebalancing

- Request Routing
    ZooKeeper

Q: In cloud systems, apps run on different nodes, and they even don't know where is the data saved.How does the partition policy work in this situation?
A: You need to know the policy of problems.

Cassandra
    http://www.cs.cornell.edu/Projects/ladis2009/papers/Lakshman-ladis2009.PDF

### Chapter 7. Transactions
#### Concurrency Control
Q: Is multi-object transactions necessary?
A: In most cases, it isn't. And considering the difficulties to implement it,what you need to consider is to only adopt normal usages.

Q: What does the circurmstance phantom mean?
A: TODO.

#### Weak Isolatin Levels
1. Read Commited (No dirty Read)
2. Snapshot Isolation (Repeatable Read)
    MVCC
3. Preventing Lost Updates
Ext:
    Raft

#### Serializability
1. Actual Serial Execution
2. Two-Phase Locking (2PL)
Q: Is 2 Phase Locking good in performance?
3. Serializable Snapshot Isolation
    SSI
Recall: MVCC

predicate lock
- 1. Index-range locks
实现方式
    next-key locking
    next-key locking = index-range locking
- 2. pessimistic vs optimistic concurrency control


Q: In what situation can we prevent write skew?
A: SSI
(write skew: 写偏斜异常, 2个并发事务修改2个不同的对象并形成竞争条件,如扣款判断)

Q: Relation of 2PL, MVCC, index-range locks and next-key locks?
A: Next-key locking is index-range locking.MVCC is a kind of concurrency control based on multi-version(instead of lock).2-Phase locking has wider range of lock and lower performance thant next-key locking.

Phantom Read: 无意中多了记录
Solution: MySQL GAP Lock, to prevent insert operation.

### Chapter 9. Consistency and Consensus
Linearizability
    Causality
    causally consistent

Sequence Number Ordering
    Lamport timestamp:seq generator consistent with causality

Total Order Broadcast
    linearizable storage on total order broadcast
        etcd
    total order broadcast on linearizable storage
    Tip: 
    Total order broadcast and linearizable storage are equivalent to consensus.

#### Consensus:
    situations:
    Leader election
        split brain
    Atomic commit

    FLP result
        2-phase commit, 2PC
            a blocking atomic commit protocol
            XA C-API
        ext. consensus algorithms:
            Zab algorithm, zookeeper
            Raft algorithm, etcd
        3-phase commit, 3PC
    Distributed Transactions in Practice

#### fault-tolerant consensus algorithms
    - Viewstamped Replication
    - Paxos
    - Raft
    - Zab

#### Zookeeper and Etcd
Usage
    allocate work
    service discovery
    membership services

### Part III. Derived Data
#### Chapter 10. Batch Processing
Command sort in unix systems
    Unix philosophy
MapReduce
    workflow schedulers
        Oozie, Azkaban, Luigi, Airflow, and Pinball
    inspires building Lucene search-index.

Beyond MapReduce
    Influence and Drawbacks
        High-level models:Pig, Hive, Cascading, Crunch
    Dataflow engines
        operators
    The Pregel processing model
        
#### Chapter 11. Stream Processing
