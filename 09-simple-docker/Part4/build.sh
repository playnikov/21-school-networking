#!/bin/bash

service nginx start
spawn-fcgi -p 8080 ./part4
nginx -s reload
tail -f /dev/null