#!/usr/bin/env bash
set -e

# Run setup
# The following commands are idempotent, so they can be run before every deploy
bundle exec rake db:migrate
bundle exec rake assets:precompile
printf "$DISCOURSE_ADMIN_EMAIL\n$DISCOURSE_ADMIN_PASSWORD\n$DISCOURSE_ADMIN_PASSWORD\nY" | bundle exec rake admin:create

# Ensure nginx is running
nginx -t
service nginx start

# Run Discourse!
foreman start --procfile=/var/www/discourse/Procfile
