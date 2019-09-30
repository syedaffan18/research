# Kubernetes

AFINITI DevOps Task 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
You need an access to a Kubernetes cluster. 

I used Google Cloud for the task. For that, you will need Google Cloud SDK & an account on GCP

We have also configured Google Filestore to work as a NFS. You will need to configure yours and add its IP to "persistentVolume.yaml" 

```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
The Docker folder has the simple Dockerfile that creates an image of the container we are interested it.

docker build -t <FOLDER>  will build the image

Now you need to push the image to a cloud registery such as GCR or DOCKER HUB. I used GCR for this. You can do the following for thi:

docker tag <IMAGE> gcr.io/<PROJECT_ID_ON_GCP>/<IMAGE>:latest 

gcloud docker -- push gcr.io/<PROJECT_ID_ON_GCP>/<IMAGE>:latest 

(Optional) docker run -it -d <IMAGE> will build the container 

The Build folder has all the yaml files, which you need to build your cluster 

kubectl create -f <YAML_FILE> will create yaml files. Alternatively, you can kubectl apply -f <YAML_FILE> 
```

