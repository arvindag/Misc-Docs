#### Go lang Tour
https://golang.org/ is the site to start learning Go language. Another good page is https://gobyexample.com/. Good link on go data structures and memory allocation is http://research.swtch.com/godata.

good 50 shades of go: http://devs.cloudimmunity.com/gotchas-and-common-mistakes-in-go-golang/

Go code formatting command is ```go fmt <filename>.go```

Some of the useful packages are:

http https://golang.org/pkg/net/http/

ioutil https://golang.org/pkg/io/ioutil/

errors https://golang.org/pkg/errors/

##### Rest server
https://thenewstack.io/make-a-restful-json-api-go/

##### Reflections
https://blog.golang.org/laws-of-reflection is a good starting point. Then graduate to http://blog.ralch.com/tutorial/golang-reflection/ good example site.
##### GRPC
Golang usage of GRPC : https://talks.golang.org/2015/gotham-grpc.slide#1. Another good example of GRPC at http://www.grpc.io/docs/tutorials/basic/go.html.

GRPC Security: https://github.com/grpc/grpc-go/blob/master/examples/route_guide/client/client.go and https://github.com/grpc/grpc-go/blob/master/clientconn_test.go

Another one using protobuf at http://www.minaandrawos.com/2014/05/27/practical-guide-protocol-buffers-protobuf-go-golang/

##### Protobuf
Protobuf: http://www.minaandrawos.com/2014/05/27/practical-guide-protocol-buffers-protobuf-go-golang/ good start. Also https://developers.google.com/protocol-buffers/docs/proto3 has good details for proto3.

#### Security
For openssl keys:
https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs and https://msol.io/blog/tech/create-a-self-signed-ssl-certificate-with-openssl/

#### Kingpin
https://github.com/alecthomas/kingpin is a good wrapper on top of flags and much better and versatile to use.

#### Cobra
https://github.com/spf13/viper is a best CLI for golang which includes cobra as a companion. https://medium.com/@skdomino/writing-better-clis-one-snake-at-a-time-d22e50e60056 is a good example for starting on viper.

#### Tablewriter
https://github.com/olekukonko/tablewriter for simple ascii tables similar to CSV format

#### Simple REST server
http://thenewstack.io/make-a-restful-json-api-go/ is a good example. Another simple server using protobuf at https://jacobmartins.com/2016/05/24/practical-golang-using-protobuffs/

#### Kafka and Avro Go client
https://github.com/confluentinc/confluent-kafka-go/tree/master/kafka for kafka client.
https://github.com/alanctgardner/gogen-avro for avro client.

#### Primer on Golang concurrency
https://medium.com/rungo/achieving-concurrency-in-go-3f84cbf870ca and https://blog.nindalf.com/posts/how-goroutines-work/
