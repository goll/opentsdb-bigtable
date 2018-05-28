# opentsdb-bigtable
Docker image that builds OpenTSDB using Bigtable with latest asyncbigtable.

* Base image used is `ubuntu:16.04`
* Using latest asyncbigtable built from official [repository](https://github.com/OpenTSDB/asyncbigtable) with:
```
<dependency>
  <groupId>com.google.cloud.bigtable</groupId>
  <artifactId>bigtable-hbase-2.x</artifactId>
  <version>1.3.0</version>
</dependency>
```
* OpenTSDB 2.4.0RC2 built from official [repository](https://github.com/OpenTSDB/opentsdb/releases/tag/v2.4.0RC2)

## Configuration
* Replace the placeholder [bigtable.json](files/bigtable.json) with a valid service account JSON key file
* Set the correct `google.bigtable.*` values in [opentsdb.conf](files/opentsdb.conf#L115-L132)
* Most of the options in [opentsdb.conf](files/opentsdb.conf) are set to defaults, change them to fit your needs

## Create the service account key file
```
$ export PROJECT_ID=foobar
$ gcloud iam service-accounts create bigtable --display-name=bigtable --project=${PROJECT_ID}
$ gcloud iam service-accounts keys create --iam-account=bigtable@${PROJECT_ID}.iam.gserviceaccount.com bigtable.json --project=${PROJECT_ID}
$ gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:bigtable@${PROJECT_ID}.iam.gserviceaccount.com" --role='roles/bigtable.user'
```

## Build the image
```
$ docker pull ubuntu:16.04
$ docker build -t opentsdb-bigtable:foobar .
```
