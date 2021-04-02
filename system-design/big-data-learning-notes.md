
#### Spark Learning Notes
DataFrame API 有哪些


Dataset API 有哪些
~~~java
class Dataset<T> extends Object implements scala.Serializable

org.apache.spark.sql.Dataset<T>

~~~

两个流处理组件:  
    Spark Streaming 和 Structured Streaming

#### 案例分析
~~~java
rideId
taxiId
driverId
isStart
startTime
endTime
startLon
startLat
endLon
endLat
passengerCnt
~~~

Spark optimized execution engine

Hive

Dataset and DataFrame有什么用?

map

flatMap

filter

flume, kafka, storm, handoop

#### Beam模型

#### WordCount Beam Pipeline

~~~java
PipelineOptions options = PipelineOptionsFactory.create();
Pipeline p = Pipeline.create(options);

PCollection<String> words = lines.apply("ExtractWords", FlatMapElements
        .into(TypeDescriptors.strings())
        .via((String word) -> Arrays.asList(word.split("[^\\p{L}]+"))));
~~~


#### References
蔡元楠 geektime learning notes
