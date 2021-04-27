#!/usr/bin/env bash
set -euo pipefail

# Start redis-server temporarily to compile assets
mkdir -p /var/www/discourse/public/uploads/redis
redis-server redis.conf &

# Run setup
# The following commands are idempotent, so they can be run before every deploy
bundle exec rake db:migrate
bundle exec rake assets:precompile
printf "%s\n%s\n%s\nY\n" $DISCOURSE_ADMIN_EMAIL $DISCOURSE_ADMIN_PASSWORD $DISCOURSE_ADMIN_PASSWORD | bundle exec rake admin:create

kill %1

# Ensure nginx is configured properly
nginx -t

# Run Discourse!
foreman start --procfile=/var/www/discourse/Procfile
