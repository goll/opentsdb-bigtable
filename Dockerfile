FROM debian:stretch-slim

ENV TSDB_VERSION=2.4.0 \
    PATH="${PATH}:/opt/opentsdb/opentsdb-2.4.0/build"

RUN mkdir -p /opt/opentsdb /usr/share/man/man1 \
 && apt-get -qq update \
 && DEBIAN_FRONTEND=noninteractive apt-get -qq --no-install-recommends install git autoconf automake gawk openjdk-8-jdk-headless curl make python gnuplot-nox \
 && rm -rf /var/lib/apt/lists/*

COPY files/*.jar files/include.mk /opt/opentsdb/

WORKDIR /opt/opentsdb

RUN git clone --quiet --depth 1 --branch v2.4.0 https://github.com/OpenTSDB/opentsdb.git opentsdb-${TSDB_VERSION} \
 && cd opentsdb-${TSDB_VERSION} \
 && mv /opt/opentsdb/include.mk third_party/asyncbigtable/include.mk \
 && mv /opt/opentsdb/*.jar third_party/asyncbigtable/ \
 && sed -i '/ASYNCBIGTABLE_VERSION/a\
          <systemPath>@ASYNCBIGTABLE_FILE_LOCATION@</systemPath>' pom.xml.in \
 && bash build-bigtable.sh \
 && ln -s /opt/opentsdb/opentsdb-${TSDB_VERSION}/build/staticroot /opt/opentsdb/staticroot

COPY files/opentsdb.conf files/bigtable.json /opt/opentsdb/

EXPOSE 4242

ENTRYPOINT ["tsdb", "tsd", "--config=/opt/opentsdb/opentsdb.conf"]
