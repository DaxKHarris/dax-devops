#!/bin/bash

cd ~/Documents/Git/dax-devops/projects/pipeline-sim && sudo docker build -t pipeline-image .
echo "Dockerfile built!"

sudo docker run --rm -it -v "$HOME/.ssh:/root/.ssh:ro" -v "$(pwd)/../..:/pipeline" pipeline-image

sudo docker image prune