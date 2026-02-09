#!/usr/bin/env bash

source .env
scripts_dir=$(realpath "$(dirname $0)")
source $scripts_dir/vars.sh

docker build --pull --no-cache \
    -t "${proxy_image_name}" \
    -f ./Dockerfile .
