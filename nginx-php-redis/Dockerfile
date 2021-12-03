# 创建基于centos7搭建lnmp镜像

# 基础镜像
FROM centos:7

# 添加安装包文件
ADD ./soft /home/soft/

#维护者
MAINTAINER qinlh@outlook.com

#安装nginx-1.14.2
RUN groupadd www \
    && useradd -r -g www -s /bin/false www \
    && yum install -y pcre-devel wget net-tools gcc zlib zlib-devel make openssl-devel initscripts \
    && cd /home/soft \
    && tar -zxvf nginx-1.14.2.tar.gz \
    && cd nginx-1.14.2 \
    && ./configure \ 
    && make \
    && make install \
    && /usr/local/nginx/sbin/nginx \
    && ln -sf /usr/local/nginx/sbin/nginx /usr/bin/nginx \
    && rm -rf /home/soft/nginx-1.14.2
ADD ./init.d/nginx /etc/init.d/nginx
RUN chmod 755 /etc/init.d/nginx

# 安装php-7.0.33
RUN groupadd www-data \
    && useradd -r -g www-data -s /bin/false www-data \
    && yum install -y php-devel gcc libXpm-devel libxml2 libxml2-devel openssl openssl-devel bzip2 bzip2-devel libcurl libcurl-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel gmp gmp-devel libmcrypt libmcrypt-devel readline readline-devel libxslt libxslt-devel psmisc \
    && cd /home/soft \
    && tar zxvf php-7.0.33.tar.gz \
    && cd php-7.0.33 \
    && ./configure \ 
    --prefix=/usr/local/php \
    --with-curl \
    --with-freetype-dir \
    --with-gd \
    --with-gettext \
    --with-iconv-dir \
    --with-kerberos \
    --with-libdir=lib64 \
    --with-libxml-dir \
    --with-mysqli \
    --with-openssl \
    -with-pcre-regex \
    --with-pdo-mysql \
    --with-pdo-sqlite \
    --with-pear \
    --with-png-dir \
    --with-xmlrpc \
    --with-xsl \
    --with-zlib \
    --enable-fpm \
    --enable-bcmath \
    --enable-libxml \
    --enable-inline-optimization \
    --enable-mbregex \
    --enable-mbstring \
    --enable-opcache \
    --enable-pcntl \
    --enable-shmop \
    --enable-soap \
    --enable-sockets \
    --enable-sysvsem\
    --enable-xml \
    --enable-zip \
    && make \ 
    && make install \
    && cp /home/soft/php-7.0.33/php.ini-production /usr/local/php/lib/php.ini \
    && cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf \
    && cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf \
    && ln -sf /usr/local/php/bin/php /usr/bin/php \
    && rm -rf /home/soft/php-7.0.33
ADD ./etc/php/php.ini /usr/local/php/lib/php.ini
ADD ./init.d/php-fpm /etc/init.d/php-fpm
RUN chmod 755 /etc/init.d/php-fpm

# 安装redis扩展
RUN cd /home/soft/ \
    && tar -zxvf redis-4.2.0.tgz \
    && cd redis-4.2.0 \
    && phpize \
    && ./configure --with-php-config=/usr/local/php/bin/php-config \
    && make \
    && make install \
    && rm -rf /home/soft/redis-4.2.0

# 安装redis-5.0.3服务
RUN cd /home/soft/ \
    && tar -zxvf redis-5.0.3.tar.gz \
    && cd redis-5.0.3 \
    && make \
    && make install PREFIX=/usr/local/redis \
    && mkdir /usr/local/redis/etc/ \
    && mkdir -p /usr/docker/redis/data/ \
    && cp /home/soft/redis-5.0.3/redis.conf /usr/local/redis/etc/redis.conf \
    && ln -sf /usr/local/redis/bin/redis-cli /usr/bin/redis \
    && rm -rf /home/soft/redis-5.0.3
ADD ./etc/redis/redis.conf /usr/local/redis/etc/redis.conf
ADD ./init.d/redis /etc/init.d/redis
RUN chmod 755 /etc/init.d/redis

# 安装导出PDF工具wkhtmltopdf
RUN yum install -y fontconfig libXrender xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 libXext libjpeg openssl\
    && cp /home/soft/wkhtmltox/MSYHBD.TTC /usr/share/fonts/ \
    && cp /home/soft/wkhtmltox/MSYHL.TTC /usr/share/fonts/ \
    && cp /home/soft/wkhtmltox/simsun.ttc /usr/share/fonts/ \
    && rpm -ivh /home/soft/wkhtmltox/wkhtmltox-0.12.6-1.centos7.x86_64.rpm || true

# 安装node.js-11
RUN curl -sL https://rpm.nodesource.com/setup_11.x | bash - \
    && yum install -y nodejs

COPY ./index.html /usr/local/nginx/html/index.html

COPY entrypoint.sh ./entrypoint.sh
RUN chmod 777 ./entrypoint.sh

# 容器启动时执行指令
ENTRYPOINT ["./entrypoint.sh"]
CMD ["-D"]