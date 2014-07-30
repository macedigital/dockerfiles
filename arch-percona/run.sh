#!/bin/bash

VOLUME_HOME="/var/lib/mysql"
MYSQL_USER=mysql

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    # stupid hack so 'fill_help_tables.sql' is found
    cd /usr 
    mysql_install_db --user=$MYSQL_USER --datadir=$VOLUME_HOME > /dev/null 2>&1
    create_mysql_admin_user.sh
    echo "=> Done!"
else
    echo "=> Using an existing volume of MySQL"
fi

exec mysqld_safe --user=mysql --datadir=$VOLUME_HOME

