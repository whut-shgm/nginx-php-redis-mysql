# 创建基于centos7搭建Mysql-5.6

# 基础镜像
FROM centos:7

# 添加安装包文件
COPY ./soft/mysql-5.6.48.tar.gz /home/soft/mysql-5.6.48.tar.gz

#维护者
MAINTAINER qinlh@outlook.com

# 安装手动编译Mysql-5.6
RUN groupadd mysql && useradd -r -g mysql -s /bin/false mysql \
    && mkdir -p /data/mysql/data \
    && chown -R mysql:mysql /data/mysql \
    && yum -y install pcre-devel wget net-tools zlib zlib-devel make cmake openssl-devel initscripts gcc gcc-c++ ncurses-devel bison perl perl-devel autoconf \
    && cd /home/soft/ \
    && tar -zxvf mysql-5.6.48.tar.gz \
    && cd mysql-5.6.48 \
    && cmake -DMYSQL_USER=mysql \
    -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
    -DINSTALL_DATADIR=/data/mysql/data \
    -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock \
    -DDEFAULT_CHARSET=utf8  \
    -DDEFAULT_COLLATION=utf8_general_ci \
    -DEXTRA_CHARSETS=all \
    -DWITH_EMBEDDED_SERVER=1 \
    -DENABLED_LOCAL_INFILE=1 \
    -DWITH_MYISAM_STORAGE_ENGINE=1 \
    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    && make \
    && make install \
    && chown -R mysql:mysql /usr/local/mysql \
    && cp /home/soft/mysql-5.6.48/support-files/my-default.cnf /usr/local/mysql/my-default.cnf \
    && cp /home/soft/mysql-5.6.48/support-files/my-default.cnf /etc/my.cnf \
    && cp /home/soft/mysql-5.6.48/support-files/mysql.server /etc/init.d/mysqld \
    && chmod a+x /etc/init.d/mysqld \
    && /usr/local/mysql/scripts/mysql_install_db --user=mysql --defaults-file=/etc/my.cnf --basedir=/usr/local/mysql --datadir=/data/mysql/data \
    && ln -sf /usr/local/mysql/bin/mysql /usr/bin/mysql \
    && rm -rf /home/soft/mysql-5.6.48
ADD ./init.d/mysqld /etc/init.d/mysqld
RUN chmod 755 /etc/init.d/mysqld

COPY entrypoint.sh ./entrypoint.sh
RUN chmod 777 ./entrypoint.sh

# 容器启动时执行指令
ENTRYPOINT ["./entrypoint.sh"]
CMD ["-D"]