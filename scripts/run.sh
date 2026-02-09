#!/usr/bin/env bash

source .env
scripts_dir=$(realpath "$(dirname $0)")
source $scripts_dir/vars.sh

echo $scripts_dir/run-tunnel.sh
$scripts_dir/run-tunnel.sh

echo "EZD_HOST=${EZD_HOST}"

# docker run -it -d \
#   --name $proxy_container_name \
#   --restart unless-stopped \
#   --network ezd-proxy-net \
#   -p ${CLOUDFLARE_TUNNEL_PORT}:80 \
#   -e EZD_HOST=${EZD_HOST} \
#   $proxy_image_name

docker run -it -d \
  --name $proxy_container_name \
  --restart unless-stopped \
  --network ezd-proxy-net \
  --add-host ezd-internal:host-gateway \
  -p ${CLOUDFLARE_TUNNEL_PORT}:80 \
  -p 443:443 \
  -p 443:443/udp \
  -v ./caddy/conf:/etc/caddy \
  -v ./caddy_data:/data \
  -e EZD_HOST=${EZD_HOST} \
  caddy:2.10.2

# -p ${CLOUDFLARE_TUNNEL_PORT}:80 \ \

# --add-host ezd-internal:host-gateway \
# -v ./nginx/templates/0-nginx.conf.template:/usr/local/share/www/0-nginx.conf.template:ro \
# -v ./nginx/templates/0-nginx.conf.template:/etc/nginx/templates/0-nginx.conf.template:ro \
# -v ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
`: #  ' `
`: # https://forums.docker.com/t/how-to-reach-localhost-on-host-from-docker-container/113321/5 `

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