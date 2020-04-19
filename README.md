[![CircleCI](https://circleci.com/gh/fernanalegria/DevOps_Microservices.svg?style=shield)](https://app.circleci.com/pipelines/github/fernanalegria/DevOps_Microservices)

## Project Overview

This project is meant to apply the skills acquired in the chapter "Microservices at Scale using AWS & Kubernetes" of Udacity's Cloud DevOps nanodegree. The ultimate goal is to operationalize a Machine Learning Microservice API in a production-like environment.

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests the ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

The project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In order to demonstrate the acquired skills, the project covers the following tasks:
* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Deploy your containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that your code has been tested

The project assessment is based on the specifications stated in the [rubric](https://review.udacity.com/#!/rubrics/2576/view) provided by Udacity.

---

## Setup the local environment

* Create a virtualenv and activate it
```
make setup
source ~/.devops/bin/activate
```
* Run `make install` to install the necessary dependencies

### Getting up and running

There are three different ways in which the API can be launched.

1. Standalone:  `python app.py`  (from the virtual environment)
2. Run in Docker:  `bash ./run_docker.sh`. This bash script builds the Docker image, lists the existing images and runs the image in a Docker container
3. Run in Kubernetes:  `bash ./run_kubernetes.sh`. This bash script cleans up previous deployments, pulls the image from Docker Hub, runs it in a Kubernetes pod and forwards the listening port to the host.

### Make predictions

Once the API is running you can make predictions given some input data. Test it out by running `bash ./make_prediction.sh`. For a detailed explanation about the input parameters, you can refer to [the Kaggle site](https://www.kaggle.com/c/boston-housing).

In addition to the given bash script, you can also hit the prediction endpoint from an API client like [Postman](https://www.postman.com/).

### Upload changes to Docker Hub

In order to upload any changes to the project to Docker Hub, a valid access token is required. Place the token in `~/docker_access_token.txt` and run `bash ./upload_docker.sh`. This will upload the image tagged as `boston-housing:latest` in your local Docker environment.

### Project structure and files

```bash
.
├── Dockerfile # File with instructions on how to build the Docker image based on an python base image
├── Makefile # Unix file to automate actions like project setup, the installation of project dependencies and test linting
├── README.md # Documentation
├── app.py # Main file that specifies the API functionality
├── make_prediction.sh # Shell script to call the API and retrieve a prediction
├── model_data
│   ├── boston_housing_prediction.joblib # Machine Learning model used to make the prediction
│   └── housing.csv # Data used to train the Machine Learning model
├── output_txt_files
│   ├── docker_out.txt # Docker container logs after making a request to retrieve the prediction
│   ├── kubernetes_logs.txt # Kubernetes pod logs after making a request to retrieve the prediction
│   └── kubernetes_out.txt # Kubernetes output when running run_kubernetes.sh
├── pylintrc # PyLint format specifications
├── requirements.txt # List of required third party Python libraries
├── run_docker.sh # Bash script to run the API in Docker
├── run_kubernetes.sh # Bash script to run the API in Kubernetes
└── upload_docker.sh # Bash script to upload the Docker image to Docker Hub
```