#### Indexing
http://stackoverflow.com/questions/1108/how-does-database-indexing-work is a good read on why indexing is needed.

https://en.wikipedia.org/wiki/Database_index is on wiki

#### What is an index?

So, what is an index? Well, an index is a data structure (most commonly a B- tree) that stores the values for a specific column in a table. An index is created on a column of a table. So, the key points to remember are that an index consists of column values from one table, and that those values are stored in a data structure. The index is a data structure – remember that.

#### Clustered index Vs non-CLustered Index
http://stackoverflow.com/questions/1251636/what-do-clustered-and-non-clustered-index-actually-mean is okay

#### Elastic Search 101
http://joelabrahamsson.com/elasticsearch-101/ is a good start

Use the ``` "tokenizer": "uax_url_email"``` to analyze emails/url instead of default ``` "tokenizer": "standard"```

```sh
"type": "text" for full text search
"type: "keyword" for no analysis as is
"type": "geo_point" for geo locations
```

Some useful commands:
``` GET /client2/_mapping ```


package on top of elasticsearch named elastic https://github.com/olivere/elastic/tree/v3.0.42

#### Kubernetes

http://christopher5106.github.io/continous/deployment/2016/05/02/deploy-instantly-from-your-host-to-AWS-EC2-and-Google-Cloud-with-kubernetes.html is a good start on AWS and GC

http://kubernetes.io/docs/getting-started-guides/aws/ is good start for kubernetes on AWS

#### Docker
https://prakhar.me/docker-curriculum/ is a good starting document for docker and some examples using AWS and docker.
https://blog.talpor.com/2015/01/docker-beginners-tutorial/ is also not bad. Some of the other good ones are http://blog.flux7.com/blogs/docker/docker-tutorial-series-part-1-an-introduction, etc.
