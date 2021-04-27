nginx: nginx -g "daemon off;"
web: bundle exec puma -C /var/www/discourse/config/puma.rb
worker: bundle exec sidekiq -C /var/www/discourse/config/sidekiq.yml
logs: tail -f /var/www/discourse/log/production.log
redis: redis-server redis.conf
