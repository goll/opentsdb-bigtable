# opentsdb-bigtable
Docker image that builds OpenTSDB using Bigtable.

* Base image used is `ubuntu:16.04` with a custom built [asyncbigtable](https://github.com/OpenTSDB/asyncbigtable) jar
* asyncbigtable built from the latest released version [0.3.0](https://github.com/OpenTSDB/asyncbigtable/tree/6126a8e409fab7da75a6314a2aab1e2c2b03d774)

## Configuration
* Replace the placeholder [bigtable.json](files/bigtable.json) with a valid account JSON key file
* Set the correct `google.bigtable.*` values in [opentsdb.conf](files/opentsdb.conf)
* Most of the options in [opentsdb.conf](files/opentsdb.conf) are set to defaults, change them to fit your needs

## Build the image
```
$ docker pull ubuntu:16.04
$ docker build -t opentsdb-bigtable:foobar .
```
