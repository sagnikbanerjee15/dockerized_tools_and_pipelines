# Welcome
Repository contains Dockerfile for several software. This will serve as a central container for dockerized images for several bioinformatics tools and pipelines. 

# Steps for building and pushing docker images to GitHub

## Generate a GitHub token

1. Login to GitHub/Biogit
2. Navigate to https://github.com/settings/tokens
3. Click on "Personal access tokens" and create a new token. Save the token somewhere. This token will act as a password

## Building images from Dockerfile

`docker build -t ghcr.io/<username>/<repository name>/<image name>:<image version>`

## Logging into docker for GitHub

`docker login ghcr.io -u <username>`

Enter the previously saved token when prompted for password

## Pushing images to GitHub

`docker push ghcr.io/<username>/<repository name>/<image name>:<image version>`

You will be able to see the docker image in the packages section of the repository