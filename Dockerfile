FROM alpine:3.17

# 更新清华源
ARG MIRRORS_UPDATE=false
ARG TOKEN
RUN if [ ${MIRRORS_UPDATE} = true ]; then \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    ;fi

# 安装需要的软件与扩展并修改时区
RUN apk update && apk upgrade \
    && apk add tzdata ca-certificates curl wget \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata \
    && rm -rf /var/cache/apk/*

# RUN curl -L https://fly.io/install.sh | sh

ADD start.sh /start.sh
RUN chmod a+x /start.sh

# EXPOSE 443 80
CMD ["/start.sh"]

# docker build -t fly:latest .
# docker run -d --name fly -e TOKEN=123456 fly:latest
# docker exec -it fly sh
