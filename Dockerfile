FROM ubuntu:16.04

RUN apt-get -qq update \
 && apt-get -qq --no-install-recommends install git autoconf automake gawk openjdk-8-jdk-headless curl make python gnuplot5-nox \
 && rm -rf /var/lib/apt/lists/*

ENV TSDB_VERSION=2.3.0

RUN mkdir -p /opt/opentsdb

WORKDIR /opt/opentsdb

COPY files/*.jar files/include.mk /opt/opentsdb/

RUN git clone --depth 1 https://github.com/OpenTSDB/opentsdb.git opentsdb-${TSDB_VERSION} \
 && mv *.jar opentsdb-${TSDB_VERSION}/third_party/asyncbigtable/ \
 && mv include.mk opentsdb-${TSDB_VERSION}/third_party/asyncbigtable/ \
 && sed -i '/ASYNCBIGTABLE_VERSION/a\
          <systemPath>@ASYNCBIGTABLE_FILE_LOCATION@</systemPath>' opentsdb-${TSDB_VERSION}/pom.xml.in \
 && cd opentsdb-${TSDB_VERSION} \
 && bash build-bigtable.sh \
 && ln -s /opt/opentsdb/opentsdb-${TSDB_VERSION}/build/tsdb /usr/bin/tsdb \
 && ln -s /opt/opentsdb/opentsdb-${TSDB_VERSION}/build/staticroot /opt/opentsdb/staticroot

COPY files/opentsdb.conf files/bigtable.json /opt/opentsdb/

EXPOSE 4242

ENTRYPOINT ["/usr/bin/tsdb", "tsd", "--config=/opt/opentsdb/opentsdb.conf"]
