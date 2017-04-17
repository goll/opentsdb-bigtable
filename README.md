# opentsdb-bigtable
Docker image that builds OpenTSDB using Bigtable.

Base image used is `ubuntu:16.04` with a custom built [asyncbigtable](https://github.com/OpenTSDB/asyncbigtable) jar.
The jar was built with the following dependencies to update the [Bigtable HBase client](https://github.com/GoogleCloudPlatform/cloud-bigtable-client):

```
<dependency>
  <groupId>com.google.cloud.bigtable</groupId>
  <artifactId>bigtable-hbase-1.2</artifactId>
  <version>0.9.4</version>
</dependency>

<dependency>
  <groupId>io.netty</groupId>
  <artifactId>netty-tcnative-boringssl-static</artifactId>
  <version>1.1.33.Fork19</version>
</dependency>
```

## Configuration
* Replace the placeholder [bigtable.json](files/bigtable.json) with a valid account JSON key file
* Set the correct `google.bigtable.*` values in [opentsdb.conf](files/opentsdb.conf)
* Most of the options in [opentsdb.conf](files/opentsdb.conf) are set to defaults, change them to fit your needs

## Build the image
```
$ docker pull ubuntu:16.04
$ docker build -t opentsdb-bigtable:foobar .
```
