FROM nginx:latest AS base

COPY ./nginx/templates/0-nginx.conf.template /usr/local/share/www/0-nginx.conf.template

RUN envsubst '\$EZD_HOST' < /usr/local/share/www/0-nginx.conf.template > /etc/nginx/nginx.conf