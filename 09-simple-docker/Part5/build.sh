#!/bin/bash

service nginx start
spawn-fcgi -p 8080 ./part5
nginx -s reload
tail -f /dev/null