#!/bin/sh

set -e

dockerize -wait tcp://bbnavi-json2graphql-db:5432 -timeout 30s

bundle exec rake db:create db:migrate

# cp -r /app/public/* /assets/
rm -f /unicorn.pid

exec "$@"
