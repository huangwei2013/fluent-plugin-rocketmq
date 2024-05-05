FROM fluentd:v1.16.2-debian-1.1
USER root
# 不那么高效的版本
##  重难点都在 ffi 的安装

RUN echo "source 'https://mirrors.tuna.tsinghua.edu.cn/rubygems/'" > Gemfile \
    && gem install bundler \
    && apt-get update  \
    && apt-get install -y gnupg
RUN echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted\n" \
         "deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted\n" \
         "deb http://archive.ubuntu.com/ubuntu/ focal universe\n" \
         "deb http://archive.ubuntu.com/ubuntu/ focal-updates universe\n" \
         "deb http://archive.ubuntu.com/ubuntu/ focal multiverse\n" \
         "deb http://archive.ubuntu.com/ubuntu/ focal-updates multiverse\n" \
         "deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse\n" \
         "deb http://security.ubuntu.com/ubuntu focal-security main restricted\n" \
         "deb http://security.ubuntu.com/ubuntu focal-security universe\n" \
         "deb http://security.ubuntu.com/ubuntu focal-security multiverse" > /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32

RUN apt update && apt -y upgrade \
    && apt-get -f install \
    && apt-get install -y --fix-broken \
    && apt-get autoclean \
    && apt-get install  --allow-downgrades -y libbz2-1.0=1.0.8-2  \
    && apt-get install --allow-downgrades -y perl-base=5.30.0-9ubuntu0.5 \
    && apt-get install -y build-essential

RUN apt-get install libffi-dev
WORKDIR /
COPY ./rocketmq-client-cpp-2.0.0.amd64.deb /rocketmq-client-cpp-2.0.0.amd64.deb
COPY ./fluent-plugin-rocketmq-0.0.10.gem /fluent-plugin-rocketmq-0.0.10.gem

RUN dpkg  -i /rocketmq-client-cpp-2.0.0.amd64.deb
RUN gem install ffi
RUN gem install rocketmq-client-ruby
RUN fluent-gem install /fluent-plugin-rocketmq-0.0.10.gem
CMD ["fluentd"]