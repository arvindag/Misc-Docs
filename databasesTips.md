#### Indexing
http://stackoverflow.com/questions/1108/how-does-database-indexing-work is a good read on why indexing is needed.

https://en.wikipedia.org/wiki/Database_index is on wiki

##### What is an index?

So, what is an index? Well, an index is a data structure (most commonly a B- tree) that stores the values for a specific column in a table. An index is created on a column of a table. So, the key points to remember are that an index consists of column values from one table, and that those values are stored in a data structure. The index is a data structure – remember that.

##### Clustered index Vs non-CLustered Index
http://stackoverflow.com/questions/1251636/what-do-clustered-and-non-clustered-index-actually-mean is okay

##### Elastic Search 101
http://joelabrahamsson.com/elasticsearch-101/ is a good start. Good explanation on inverted index is http://techblogsearch.com/a/text-processing-part-2-inverted-index.html.

Index Vs Type document: https://www.elastic.co/blog/index-vs-type

Use the ``` "tokenizer": "uax_url_email"``` to analyze emails/url instead of default ``` "tokenizer": "standard"```.

``` "date_detection": false ``` can be set in the typename area also.

```sh
"type": "text" for full text search and is sent through an analyzer.
"type: "keyword" for no analysis as is.
"type": "geo_point" for geo locations.
"type": "nested", "include_in_parent": true us useful to do nested queries.
```
```sh
"enabled: false" for just stored with no indexing. Default is true.
"index: fasle" for Fields that are not indexed are not queryable. Default is true.
```
Some useful commands:
``` GET /client2/_mapping ```

ES can use Gobal Ordinals which is like enum on top of finite number of choices among strings to reduce the memory footprint. That way it does not need to store long strings but just small integers.

package on top of elasticsearch named elastic https://github.com/olivere/elastic/tree/v3.0.42

##### Elasticsearch schemaless issues
https://www.ctl.io/developers/blog/post/improved-elasticsearch-indexing shows how schemaless also maps internally to schema as Lucene uses schema.
https://www.elastic.co/blog/found-elasticsearch-mapping-introduction shows the introduction to creating schema.

#### Kubernetes

http://christopher5106.github.io/continous/deployment/2016/05/02/deploy-instantly-from-your-host-to-AWS-EC2-and-Google-Cloud-with-kubernetes.html is a good start on AWS and GC

http://kubernetes.io/docs/getting-started-guides/aws/ is good start for kubernetes on AWS

#### Docker
https://prakhar.me/docker-curriculum/ is a good starting document for docker and some examples using AWS and docker.
https://blog.talpor.com/2015/01/docker-beginners-tutorial/ is also not bad. Some of the other good ones are http://blog.flux7.com/blogs/docker/docker-tutorial-series-part-1-an-introduction, etc.

#### Cassandra
When data is written to Cassandra, it is first written to a commit log, which ensures full data durability and safety. Data is also written to an in-memory structure called a memtable, which is eventually flushed to a disk structure called an sstable (sorted strings table).

#### Kafka Vs RabbitMQ
**RabbitMQ** is broker-centric, focused around delivery guarantees between producers and consumers.
**Kafka** is producer-centric. preserving ordered delivery within a partition. If Kafka queue is full, then it
will drop messages and hence consumers might get get the message even once. Kafka has better performance than RabbitMQ. Unlike other message system, Kafka brokers are stateless. Also Kafka performance is better as it does linear disk I/O and work on batching together small bits of data into larger network and disk I/O operations.

With **Kafka** you can do both real-time and batch processing. Ingest tons of data, route via publish-subscribe (or queuing). The broker barely knows anything about the consumer. All that’s really stored is an “offset” value that specifies where in the log the consumer left off. Unlike many integration brokers that assume consumers are mostly online, Kafka can successfully persist a lot of data, and supports “replay” scenarios. The architecture is fairly unique; topics are arranged in partitions (for parallelism), and partitions are replicated across nodes (for high availability).

**RabbitMQ** is a messaging engine that follows the AMQP 0.9.1 definition of a broker. It follows a standard store-and-forward pattern where you have the option to store the data in RAM, on disk, or both. It supports a variety of message routing paradigms. RabbitMQ can be deployed in a clustered fashion for performance, and mirrored fashion for high availability. Consumers listen directly on queues, but publishers only know about “exchanges.” These exchanges are linked to queues via bindings, which specify the routing paradigm (among other things).

Note that unlike most messaging systems the **Kafka** log is always persistent. Messages are immediately written to the filesystem when they are received. Messages are not deleted when they are read but retained with some configurable SLA (say a few days or a week). This allows usage in situations where the consumer of data may need to reload data. It also makes it possible to support space-efficient publish-subscribe as there is a single shared log no matter how many consumers; in traditional messaging systems there is usually a queue per consumer, so adding a consumer doubles your data size. This makes Kafka a good fit for things outside the bounds of normal messaging systems such as acting as a pipeline for offline data systems such as Hadoop. These offline systems may load only at intervals as part of a periodic ETL cycle, or may go down for several hours for maintenance, during which time Kafka is able to buffer even TBs of unconsumed data if needed. Producers get an acknowledgement back when they publish a message containing the record's offset. The first record published to a partition is given the offset 0, the second record 1, and so on in an ever-increasing sequence. Consumers consume data from a position specified by an offset, and they save their position in a log by committing periodically: saving this offset in case that consumer instance crashes and another instance needs to resume from it's position.

Kafka performance paper by Jay Krepps: https://engineering.linkedin.com/kafka/benchmarking-apache-kafka-2-million-writes-second-three-cheap-machines

Another good article; http://www.cloudhack.in/2016/02/29/apache-kafka-vs-rabbitmq/


