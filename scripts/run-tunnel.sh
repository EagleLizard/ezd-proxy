#!/usr/bin/env bash

source .env
scripts_dir=$(realpath "$(dirname $0)")
source $scripts_dir/vars.sh

docker run -it -d \
    --name ${tunnel_container_name} \
    --restart unless-stopped \
    -v ./tunnel-conf:/etc/cloudflared \
    --network ezd-proxy-net \
    -e TUNNEL_TOKEN=${CLOUDFLARE_TUNNEL_TOKEN_EZD_API_MBP} \
    cloudflare/cloudflared:latest tunnel run
