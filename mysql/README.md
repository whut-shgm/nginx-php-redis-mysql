# mysql 单独部署
mysql(mysql-5.6) mysql单独部署一个镜像

## 使用教程(Quick start)
### 下载(Download)
```
# mysql
docker pull qinlinhui/mysql56
```
### 启动(Start)
```
# 端口映射自行指定,容器名称自行指定
# mysql
docker run -dit --privileged=true -p 3307:3306 --name=mysql56 qinlinhui/nginx-php-redis

# 高级用法(Advanced usage)
docker run -dit \
-p 3307:3306 \
-v /xxx/www:/www \
--privileged=true \
--name=mysql56 \
qinlinhui/mysql56
```
### 连接(Connect)
```
# 容器名称与上一步保持一致
docker exec -it mysql56 /bin/bash
```
### 状态(Status)
```
ps aux|grep mysqld
```
### 服务启动(Start)
```
mysql: /etc/init.d/mysqld start {start|stop|restart|reload|status|configtest|force-quit|kill}
```
### 警告(Warning)
```
# 请保持清醒头脑，明确自己是在容器内还是在服务器本身执行命令，以及-v挂载对文件的影响，以免造成不可挽回的损失
```
### 配置(Config)
```
#配置文件路径(Config file path)
# MySQL
/etc/my.cnf
```
### 日志(log)
```
#日志文件路径(log file path)
# MYSQL
/usr/local/mysql/error.log
```
### 版本(Version)
```
# 各版本详细信息请参考
https://github.com/15035574759/nginx-php-redis-mysql/mysql
```
