#!/bin/bash
nginx-php-redis() {
    docker pull centos:7
    docker-compose -f docker_lnmpr.yml up -d nginx-php-redis
}

mysql() {
    docker pull centos:7
    docker-compose -f docker_lnmpr.yml up -d mysql56
}

if [[ ${1} == 'mysql' ]]; then
    echo "mysql start..."
    mysql
fi

if [[ ${1} == 'nginx-php-redis' ]]; then
    echo "nginx-php-redis start..."
    redis
fi

echo "success"
