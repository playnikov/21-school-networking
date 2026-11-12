#!/bin/bash

docker build -t part5_img:stable .
docker run -d -p 80:81 --name part5 part5_img:stable