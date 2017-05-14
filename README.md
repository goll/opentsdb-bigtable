# opentsdb-bigtable
Docker image that builds OpenTSDB using Bigtable with latest asyncbigtable.

* Base image used is `ubuntu:16.04`
* Using the latest released asyncbigtable [0.3.0](https://github.com/OpenTSDB/asyncbigtable/releases/tag/v0.3.0)
* OpenTSDB 2.3.0 built from forked [repository](https://github.com/goll/opentsdb) with updated asyncbigtable

## Configuration
* Replace the placeholder [bigtable.json](files/bigtable.json) with a valid service account JSON key file
* Set the correct `google.bigtable.*` values in [opentsdb.conf](files/opentsdb.conf#L116-L120)
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
