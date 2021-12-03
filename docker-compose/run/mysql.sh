#!/bin/bash
image_name="registry.cn-hangzhou.aliyuncs.com/qinlh/mysql56:1.0.0"
container_name="mysql56"

flag=$(docker images | grep ${image_name})
if [[ -z "${flag}" ]]; then
    docker pull ${image_name}
else
    echo "image [${image_name}] is exist"
fi

flag=$(docker ps -a | grep ${container_name})
if [[ -z "${flag}" ]]; then
    if [[ ${1} == 1 ]]; then
        docker run -itd --name ${container_name} \
            --privileged=true \
            -p 3307:3306 \
            -v ../mysql/data:/data/mysql/data \
            -v ../etc/mysql/my.cnf:/etc/my.cnf:ro \
            -v ../log/mysql/error.log:/usr/local/mysql/error.log \
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