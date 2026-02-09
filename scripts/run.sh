#!/usr/bin/env bash

source .env
scripts_dir=$(realpath "$(dirname $0)")
source $scripts_dir/vars.sh

echo $scripts_dir/run-tunnel.sh
$scripts_dir/run-tunnel.sh

docker run -it -d \
  --name $proxy_container_name \
  --restart unless-stopped \
  --network ezd-proxy-net \
  -p ${CLOUDFLARE_TUNNEL_PORT}:80 \
  -v ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
  nginx:latest

# docker run -it -d \
#     --name $container_name \
#     -p 80:80 \
#     -p 443:443 \
#     -p 443:443/udp \
#     --restart unless-stopped \
#     -v ./conf:/etc/caddy \
#     --network ezd-proxy-net \
#     --env-file ./.env \
#     caddy