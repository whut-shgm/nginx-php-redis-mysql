#!/bin/bash
image_name="registry.cn-hangzhou.aliyuncs.com/qinlh/nginx-php-redis:1.0.0"
container_name="nginx-php-redis"

flag=$(docker images | grep ${image_name})
if [[ -z "${flag}" ]]; then
    docker pull ${image_name}
else
    echo "image [${image_name}] is exist"
fi

flag=$(docker ps -a | grep ${container_name})
if [[ -z "${flag}" ]]; then
    if [[ ${1} == 1 ]]; then
        docker run -itd --name ${container_name}  \
            --privileged=true \
            -p 82:80 \
            -p 63791:6379 \
            -v ./www:/home/wwwroot/ \
            -v ../log/nginx/access.log:/usr/local/nginx/logs/access.log \
            -v ../log/nginx/error.log:/usr/local/nginx/logs/error.log \
            -v ../etc/nginx/nginx.conf:/usr/local/nginx/conf/nginx.conf:ro \
            -v ../etc/nginx/conf.d/:/usr/local/nginx/conf/conf.d/:ro \
            -v ../etc/php/php.ini:/usr/local/php/lib/php.ini:ro \
            -v ../etc/php/php-fpm.conf:/usr/local/php/etc/php-fpm.conf:ro \
            -v ../etc/php/php-fpm.d/www.conf:/usr/local/php/etc/php-fpm.d/www.conf:ro \
            -v ../log/php/php-fpm.log:/usr/local/php/var/log/php-fpm.log \
            -v ../log/php/php_errors.log:/usr/local/php/var/log/php_errors.log \
            -v ../redis/data:/usr/local/redis/data \
            -v ../etc/redis/redis.conf:/usr/local/redis/etc/redis.conf:ro \
            -v ../log/redis/redis.log:/var/log/redis/redis.log \
            -v /etc/localtime:/etc/localtime:ro \
            ${image_name}
    else
        echo "do not create [${container_name}]"
    fi
else
    echo "container [${container_name}] is exist"
fi

echo "[end]......"
docker images
docker ps -a