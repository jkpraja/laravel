# Apply CI/CD of Laravel Apps using Jenkins, Docker and AWS EC2

## Authors

- [@jkpraja](https://www.github.com/jkpraja)

## Topology
![CI/CD Topology](https://raw.githubusercontent.com/jkpraja/laravel/master/Project%208.png)


## Introduction
[Blogx](https://github.com/sdcilsy/blogx) is a Laravel based application which is using PHP and MySQL as its main engine. 
 
In this case, we will build a CI/CD workflow using Jenkins Pipeline.

## You'll need
- An AWS Account
- A Docker Hub Account
## What To Do
In this case, we need to do several steps:
1. Launch and Configure a Server that acts as Jenkins Master
2. Launch and Configure a Jenkins agent
3. Launch and Configure an application server
4. Dockerize the application's components and deploy locally
5. Configure Jenkins Pipeline for auto integration and deployment

#### Launch and Configure Jenkins Master
1. The server must be installed below libs:
    - Java 11
    - Docker
    - Jenkins
2. And then setup jenkins on server master
3. After jenkins is ready, install the publish over ssh plugin so that we can send files over ssh to the remote agent.


#### Launch and Configure a Jenkins agent
1. On Jenkins dashboard, configure clouds and connect it to Amazon web services. In this step, we need to create a new access key first.
2. And then prepare the AMI that will be used in Jenkins agent. This AMI should have libs Java 11 and Docker installed.
3. If the process is completed, test the provisioning.

#### Launch and Configure Application server
1. Launch an EC2 instance on Amazon Web Services that will act as application server.
2. In this instance, Java 11 and Docker have to be installed too.
3. Connect the application server on Jenkins too.


#### Dockerize Applications
1. Create a Dockerfile for the BlogX. Since it's a php based app, then we might need to use PHP images from Docker hub as a base image. In this case, we'll be using PHP7.4-FPM.
2. Don't forget to install dependencies in order to make the app run smoothly.
3. Copy the project directory to the container and also create .env file.
4. Update the .env file variables.
5. Install the composer.
6. Add entrypoint to start the development server.
7. If it's running, then you can test it locally.

#### CI/CD with Jenkins
1. Create a new pipeline on Jenkins by connecting it to Github Repository.
2. Write a jenkinsfile that breaks down the process into 3 stages:
    - Prepare the Environment variables
    - Build Laravel app
    - Deployment
3. In Deployment step, we need to transfer the compose file, a database configuration file and runapp script to the application server first.


That's all. This project is completed!
