#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH
LANG=en_US.UTF-8

if [ ! -f "/root/.fly/bin/flyctl" ]; then
    curl -L https://fly.io/install.sh | sh
fi

if [ -f "/root/.fly/bin/flyctl" ]; then
    ln -s /root/.fly/bin/flyctl /bin/flyctl
    ln -s /root/.fly/bin/flyctl /bin/fly
fi

if [ ! -f "/root/.fly/config.yml" ]; then
    echo "access_token: ${TOKEN}" >/root/.fly/config.yml
fi

# 持续运行
tail -f /dev/null
