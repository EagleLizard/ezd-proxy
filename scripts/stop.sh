
scripts_dir=$(realpath "$(dirname $0)")
source $scripts_dir/vars.sh

docker stop $proxy_container_name
docker rm $proxy_container_name

docker stop $tunnel_container_name
docker rm $tunnel_container_name