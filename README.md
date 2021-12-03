# nginx-php-redis + mysql 分布部署
nginx+php+redis环境(centos7+nginx-1.14.2+php-7.0.33+redis-5.0.3+nodejs-11+wkhtmltox-0.12.6)
    +
mysql(mysql-5.6) mysql单独部署一个镜像

## 使用教程(Quick start)
### 下载(Download)
```
# nginx-php-redis 
docker pull qinlinhui/nginx-php-redis
# mysql
docker pull qinlinhui/mysql56
```
### 启动(Start)
```
# 端口映射自行指定,容器名称自行指定
# nginx-php-redis
docker run -dit --privileged=true -p 81:80 --name=nginx-php-redis qinlinhui/nginx-php-redis
# mysql
docker run -dit --privileged=true -p 81:80 --name=mysql56 qinlinhui/nginx-php-redis

# 高级用法(Advanced usage)
docker run -dit \
-p 81:80 \
-p 444:443 \
-p 9001:9000 \
-v /xxx/www:/www \
--privileged=true \
--name=nginx-php-redis \
qinlinhui/nginx-php-redis
```
### 连接(Connect)
```
# 容器名称与上一步保持一致
docker exec -it nginx-php-redis /bin/bash
```
### 状态(Status)
```
ps aux|grep nginx
ps aux|grep php-fpm
ps aux|grep redis

ps aux|grep mysqld
```
### 服务启动(Start)
```
nginx: /etc/init.d/nginx start {start|stop|restart|reload|status|configtest|force-quit|kill}
php-fpm: /etc/init.d/php-fpm start {start|stop|restart|reload|status|configtest|force-quit|kill}
redis: /etc/init.d/redis start {start|stop|restart|reload|status|configtest|force-quit|kill}

mysql: /etc/init.d/mysqld start {start|stop|restart|reload|status|configtest|force-quit|kill}
```
### 警告(Warning)
```
# 请保持清醒头脑，明确自己是在容器内还是在服务器本身执行命令，以及-v挂载对文件的影响，以免造成不可挽回的损失
```
### 配置(Config)
```
#配置文件路径(Config file path)
# Nginx
/usr/local/nginx/conf/nginx.conf
/usr/local/nginx/conf/conf.d/
# PHP
/usr/local/php/lib/php.ini
/usr/local/php/etc/php-fpm.conf
/usr/local/php/etc/php-fpm.d/www.conf
# Redis
/usr/local/redis/etc/redis.conf

# MySQL
/etc/my.cnf
```
### 日志(log)
```
#日志文件路径(log file path)
# Nginx
/usr/local/nginx/logs/
# PHP
/usr/local/php/var/log/php-fpm.log
/usr/local/php/var/log/php_errors.log
# Redis
/var/log/redis/redis.log

# MYSQL
/usr/local/mysql/error.log
```

### 数据卷位置(DB)
```
# mysql
/data/mysql/data
# redis
/usr/local/redis/data
```

### PHP扩展(PHP extension)
```
# 默认已安装部分扩展在目录：/usr/local/php/lib/php/extensions/no-debug-non-zts-20151012
# 如果要启用指定扩展，则需要修改php.ini，加上
extension=xxx.so
# xxx为PHP扩展的文件名，然后重启php
service php-fpm restart
```
### 版本(Version)
```
# 各版本详细信息请参考
https://github.com/15035574759/nginx-php-redis-mysql
```
