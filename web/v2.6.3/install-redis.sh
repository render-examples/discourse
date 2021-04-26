#!/bin/bash
set -e

# version check: https://redis.io/
REDIS_VERSION=6.2.1
REDIS_HASH="cd222505012cce20b25682fca931ec93bd21ae92cb4abfe742cf7b76aa907520"

cd /tmp
# Prepare Redis source.
wget http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz
sha256sum redis-$REDIS_VERSION.tar.gz
echo "$REDIS_HASH redis-$REDIS_VERSION.tar.gz" | sha256sum -c

tar zxf redis-$REDIS_VERSION.tar.gz
cd redis-$REDIS_VERSION

# Building and installing binaries.
make && make install PREFIX=/usr

# # Configure Redis.
mkdir -p /etc/redis
mkdir -p /var/log/redis
cp /tmp/redis-$REDIS_VERSION/redis.conf /etc/redis

# Clean up.
cd / && rm -rf /tmp/redis*
