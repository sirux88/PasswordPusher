#!/bin/bash
set -e

export RAILS_ENV=production


if [ -n "$PWP_DB" ]
then
    echo "Setting $PWP_DB database backend"
    if [ "$PWP_DB" == "sqlite" ]
    then
        export DATABASE_URL=sqlite3:db/db.sqlite3
    elif [[ "$PWP_DB" == "mysql" || "$PWP_DB" == "mariadb" ]]
    then
        export DATABASE_URL=mysql2://passwordpusher_user:passwordpusher_passwd@mysql:3306/passwordpusher_db
    elif [ "$PWP_DB" == "postgres" ]
    then
        export DATABASE_URL=postgres://passwordpusher_user:passwordpusher_passwd@postgres:5432/passwordpusher_db
    else 
        echo "Unknown database backend $PWP_DB. Exiting..."
        exit
    fi
    
else 
    echo "No database backend set. Exiting..."
    exit
fi

echo "Password Pusher: migrating database to latest..."
bundle exec rake db:migrate

if [ "$PWP_PRECOMPILE" == "true" ]
then
    echo "Password Pusher: precompiling assets for customisations..."
    bundle exec rails assets:precompile
fi

echo "Password Pusher: starting puma webserver..."
bundle exec puma -C config/puma.rb

exec "$@"
