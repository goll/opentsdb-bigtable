# opentsdb-bigtable
Docker image that builds OpenTSDB using Bigtable with latest asyncbigtable.

* Base image used is `debian:stretch-slim`
* Using latest asyncbigtable from official [repository](https://oss.sonatype.org/content/repositories/snapshots/com/pythian/opentsdb/asyncbigtable/0.4.1-SNAPSHOT/)
* OpenTSDB 2.4.0 built from official [repository](https://github.com/OpenTSDB/opentsdb/releases/tag/v2.4.0)

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
$ docker pull debian:stretch-slim
$ docker build -t opentsdb-bigtable:foobar .
```
