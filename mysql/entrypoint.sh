#!/bin/bash
set -e

echo `service mysqld status`
echo '1.启动mysql....'
/etc/init.d/mysqld restart
sleep 3
echo `service mysqld status`

tail -f /dev/null