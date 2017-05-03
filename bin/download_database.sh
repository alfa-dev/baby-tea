#!/bin/bash

# https://devcenter.heroku.com/articles/heroku-postgres-import-export

APP=baby-tea

if [ -z "$SKIP_BACKUP" ]; then
    heroku pg:backups:capture --app $APP
    rm -rf latest.dump
fi

wget --continue -O latest.dump `heroku pg:backups:url --app $APP` &&
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U `whoami` -d baby-tea latest.dump

rails runner 'puts User.update_all(password_digest: "$2a$10$lVqrVfWSoYekDvKl1pHFoey3NZ/gof8g7AB.HTQHSptIE8iQ2bPDq")'
rails runner 'puts ApiClient.update_all(encrypted_app_secret: "$2a$10$TpqEu5ig2F5qc5Ap9KJYSeAm2GysbbiCuZg6NuUiMyGewJMWUUNhG")'
