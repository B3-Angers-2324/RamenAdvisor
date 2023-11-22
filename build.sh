#!/bin/bash

# Check if all three arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <relative_path> <image_name> <version>"
    exit 1
fi

# Assign arguments to variables
relative_path=$1
image_name=$2
version=$3

# Use the multarch builder
docker buildx use multarchbuilder
# Cd to the subdirectory
cd $relative_path
# Build the image and push it
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t $image_name:latest -t $image_name:v$version . --push
# Reset the builder
docker context use default
#docker buildx user default

echo "Done"
