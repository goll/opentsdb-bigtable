FROM ubuntu:16.04

RUN apt-get -qq update \
 && apt-get -qq --no-install-recommends install git autoconf automake gawk openjdk-8-jdk-headless curl make python gnuplot5-nox \
 && rm -rf /var/lib/apt/lists/*

ENV TSDB_VERSION=2.3.0

RUN mkdir -p /opt/opentsdb

WORKDIR /opt/opentsdb

RUN git clone --quiet --depth 1 https://github.com/goll/opentsdb.git opentsdb-${TSDB_VERSION} \
 && cd opentsdb-${TSDB_VERSION} \
 && bash build-bigtable.sh \
 && ln -s /opt/opentsdb/opentsdb-${TSDB_VERSION}/build/tsdb /usr/bin/tsdb \
 && ln -s /opt/opentsdb/opentsdb-${TSDB_VERSION}/build/staticroot /opt/opentsdb/staticroot

COPY files/opentsdb.conf files/bigtable.json /opt/opentsdb/

EXPOSE 4242

ENTRYPOINT ["/usr/bin/tsdb", "tsd", "--config=/opt/opentsdb/opentsdb.conf"]
