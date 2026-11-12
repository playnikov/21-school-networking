#!/bin/bash

docker build -t part4_img .
docker run -d -p 80:81 --name part4 part4_img