#!/bin/bash
set -eo pipefail

# if command starts with an option, prepend mysqld
if [ "${1:0:1}" = '-' ]; then
    set -- mysqld "$@"
fi

# skip setup if they want an option that stops mysqld
wantHelp=
for arg; do
    case "$arg" in
        -'?'|--help|--print-defaults|-V|--version)
            wantHelp=1
            break
            ;;
    esac
done

if [ "$1" = 'mysqld' -a -z "$wantHelp" ]; then
    # Get config
    DATADIR="$("$@" --verbose --help 2>/dev/null | awk '$1 == "datadir" { print $2; exit }')"

    if [ ! -d "$DATADIR/mysql" ]; then
        if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" -a -z "$MYSQL_RANDOM_ROOT_PASSWORD" ]; then
            echo >&2 'error: database is uninitialized and password option is not specified '
            echo >&2 '  You need to specify one of MYSQL_ROOT_PASSWORD, MYSQL_ALLOW_EMPTY_PASSWORD and MYSQL_RANDOM_ROOT_PASSWORD'
            exit 1
        fi

        mkdir -p "$DATADIR"
        chown -R mysql:mysql "$DATADIR"

        echo 'Initializing database'
        mysqld --initialize-insecure --datadir="$DATADIR"
        echo 'Database initialized'

        "$@" --skip-networking &
        pid="$!"

        mysql=( mysql --protocol=socket -uroot )

        for i in {30..0}; do
            if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
                break
            fi
            echo 'MySQL init process in progress...'
            sleep 1
        done
        if [ "$i" = 0 ]; then
            echo >&2 'MySQL init process failed.'
            exit 1
        fi

        if [ -z "$MYSQL_INITDB_SKIP_TZINFO" ]; then
            # sed is for https://bugs.mysql.com/bug.php?id=20545
            mysql_tzinfo_to_sql /usr/share/zoneinfo | sed 's/Local time zone must be set--see zic manual page/FCTY/' | "${mysql[@]}" mysql
        fi

        # try enable TokuDB
        # @link https://www.percona.com/blog/2014/07/23/why-tokudb-hates-transparent-hugepages/
        ps_tokudb_admin --enable -uroot

        # install Percona Toolkit hashing functions
        "${mysql[@]}" <<-EOSQL
            CREATE FUNCTION fnv1a_64 RETURNS INTEGER SONAME 'libfnv1a_udf.so';
            CREATE FUNCTION fnv_64 RETURNS INTEGER SONAME 'libfnv_udf.so';
            CREATE FUNCTION murmur_hash RETURNS INTEGER SONAME 'libmurmur_udf.so';
EOSQL

        if [ ! -z "$MYSQL_RANDOM_ROOT_PASSWORD" ]; then
            MYSQL_ROOT_PASSWORD="$(pwmake 4096)"
            echo "GENERATED ROOT PASSWORD: $MYSQL_ROOT_PASSWORD"
        fi
        "${mysql[@]}" <<-EOSQL
            -- What's done in this file shouldn't be replicated
            --  or products like mysql-fabric won't work
            SET @@SESSION.SQL_LOG_BIN=0;
            DELETE FROM mysql.user ;
            CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
            GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
            DROP DATABASE IF EXISTS test ;
            FLUSH PRIVILEGES ;
            -- clear odd setup remains
            DELETE FROM mysql.tables_priv ;
            DELETE FROM mysql.db ;
EOSQL

        if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
            mysql+=( -p"${MYSQL_ROOT_PASSWORD}" )
        fi

        if [ "$MYSQL_DATABASE" ]; then
            echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" | "${mysql[@]}"
            mysql+=( "$MYSQL_DATABASE" )
        fi

        if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
            echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" | "${mysql[@]}"

            if [ "$MYSQL_DATABASE" ]; then
                echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" | "${mysql[@]}"
            fi

            echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
        fi

        if [ ! -z "$MYSQL_ONETIME_PASSWORD" ]; then
            "${mysql[@]}" <<-EOSQL
                ALTER USER 'root'@'%' PASSWORD EXPIRE;
EOSQL
        fi
        if ! kill -s TERM "$pid" || ! wait "$pid"; then
            echo >&2 'MySQL init process failed.'
            exit 1
        fi

        echo
        echo 'MySQL init process done. Ready for start up.'
        echo
    fi

    chown -R mysql:mysql "$DATADIR"

fi

[[ -f "/etc/sysconfig/mysql" ]] && . /etc/sysconfig/mysql

exec "$@"
