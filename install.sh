#!/bin/bash
#install abstraction layer to use docker seamless

##might as well build ever time.. 

docker build -t extractor:local .
extractor.sh
sudo install -m 0755 ./extractor.sh /usr/local/bin/extractor

sudo install -m 0755 ./extract.sh /usr/local/bin/extract
mkdir -p extractor
