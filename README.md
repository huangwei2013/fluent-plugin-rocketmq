# 简述

Fluent input plugin for RocketMQ 

# 使用
## 安装


### 本地打包 & 安装

```
gem build ./fluent-plugin-rocketmq.gemspec

gem install ./fluent-plugin-rocketmq-0.0.10.gem
```

### 镜像打包

```
docker build -f Dockerfile  . -t fluentd-rocketmq:v1.16.2
```

### 镜像运行

#### 验证镜像能否运行
```
sudo docker run -it --name=fluentRocketMQNothing  \
--log-opt max-size=20m --log-opt max-file=1 \
-v ./conf/fluentd.nothing.conf:/fluentd/etc/fluent.conf \
-v /etc/localtime:/etc/localtime \
--privileged=true  \
-d fluentd-rocketmq:v1.16.2
```

其中
```fluent.none.conf
<source>
  @type dummy
  tag dummy
</source>

<match **>
  @type stdout
</match>
```

#### 真正使用

```
sudo docker run -it --name=fluentRocketMQSample  \
--log-opt max-size=20m --log-opt max-file=1 \
-v ./conf/fluent.sample.conf:/fluentd/etc/fluent.conf \
-v /etc/localtime:/etc/localtime \
--privileged=true  \
-d fluentd-rocketmq:v1.16.2
```



