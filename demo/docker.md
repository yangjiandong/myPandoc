## 说明

- 目前使用 Docker 部署产品，采用手工启动各个服务的方式进行
- 中间件加产品大概 30 多个 docker

## 提前准备

- docker-18.03.1-ce.tgz
- docker-compose 文件
- 准备需要用到的镜像包
- 准备需要部署的服务 jar 包

```shell
# docker 版本
Client:
 Version:      18.03.1-ce
 API version:  1.37
 Go version:   go1.9.2
 Git commit:   9ee9f40
 Built:        Thu Apr 26 07:12:25 2018
 OS/Arch:      linux/amd64
 Experimental: false
 Orchestrator: swarm

Server:
 Engine:
  Version:      18.03.1-ce
  API version:  1.37 (minimum version 1.12)
  Go version:   go1.9.5
  Git commit:   9ee9f40
  Built:        Thu Apr 26 07:23:03 2018
  OS/Arch:      linux/amd64
  Experimental: false
```

```shell
# docker-compose 版本
docker-compose version 1.24.1, build 4667896b
docker-py version: 3.7.3
CPython version: 3.6.8
OpenSSL version: OpenSSL 1.1.0j  20 Nov 2018
```

### 1. Docker 服务离线安装

```shell
# 先将安装包 docker-18.03.1-ce.tgz 文件拷贝到当前路径
# 解压
tar -xzvf docker-18.03.1-ce.tgz

# 将可执行程序拷贝到 /usr/bin
sudo cp docker/* /usr/bin/

# 创建 docker.service
vi /etc/systemd/system/docker.service

# 输入以下内容
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target

[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd --graph=/home/eking/data/docker --storage-driver=overlay
ExecReload=/bin/kill -s HUP $MAINPID
# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
# Uncomment TasksMax if your systemd version supports it.
# Only systemd 226 and above support this version.
#TasksMax=infinity
TimeoutStartSec=0
# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes
# kill only the docker process, not all processes in the cgroup
KillMode=process
# restart the docker process if it exits prematurely
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target

# 启动docker服务
sudo systemctl start docker

# 设置docker服务自动启动
sudo systemctl enable docker

# 查看是否安装成功
docker -v

# 查看是否启动成功
docker images

```

### 2. Docker-compose 服务离线安装

```shell
# 将 docker-compose 放到 /usr/local/bin 目录下
mv docker-compose /usr/local/bin/

# 修改 docker-compose 权限
sudo chmod +x docker-compose

# 查看是否安装成功
docker-compose -v
```

### 3. Docker 配置 daemon.json 优化

```shell
# /etc/docker/daemon.json
{
  "log-driver":"json-file",
  "log-opts":{
    "max-size" :"5m","max-file":"1"
  },
  "bip":"188.66.10.1/24"
}

# 重启docker
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## 部署项目服务

### 1. 安装 docker 镜像

执行 `docker load -i <镜像压缩文件>` 安装镜像

### 2. 配置 SingleCfg.env

```shell
# [DEFAULT] start
COMM_DB_HOST=192.168.1.231
COMM_DB_PASSWORD=Ekinghis@jsxy2021
COMM_DB_PORT=3306
COMM_DB_TYPE=mysql
COMM_DB_USERNAME=eking
COMM_ORA_HOST=192.168.1.231
COMM_ORA_PORT=1521
COMM_ORA_SERVERNAME=EE.oracle.docker
COMM_MONGO_PORT=27017
COMM_FRONT_ADDR=http://192.168.1.231:8999
COMM_GRAFANA_ADDR=http://192.168.1.231:3000/
COMM_NACOS_HOST=192.168.1.231
COMM_NACOS_PORT=8848
COMM_NOTICE_ADDR=http://192.168.1.231:10620
COMM_REDIS_HOST=192.168.1.231
COMM_REDIS_PORT=6379
COMM_REDIS_PASSWORD=Ekinghis@jsxy2020
COMM_REDIS_DB=1
COMM_RMQ_HOST=192.168.1.231
COMM_RMQ_PASSWORD=newhis
COMM_RMQ_PORT=5672
COMM_RMQ_USERNAME=newhis
COMM_RMQ_VH=scloud-release
COMM_SCLOUD_NGINX_HOST=192.168.1.231
COMM_SCLOUD_NGINX_PORT=4431
COMM_SCLOUD_NGINX_PROTOCOL=http
COMM_SENTINEL_HOST=192.168.1.231
COMM_SENTINEL_PORT=8900
COMM_WEEDFS_HOST=192.168.1.231
COMM_WEEDFS_PORT=9333
COMM_XXL_JOB_HOST=192.168.1.231
COMM_XXL_JOB_PORT=26000
COMM_ZUUL_HOST=192.168.1.231
COMM_ZUUL_PORT=9443
# [DEFAULT] end

# [busi] start
APP_ACTIVE=pro
APP_NACOS_NAMESPACE=
APP_NACOS_SERVER_ADDR=192.168.1.231:8848
DOCKER_HOST_ADDR=192.168.1.231
#EKPAY_DB_NAME=ek_pay
#EKPAY_PORT=7500
#EKPAY_EXECUTOR_PORT=10002
EMR_DB_NAME=ek_emr
EMR_DB_PASSWORD=ek_emr123
EMR_PORT=9703
FRONT_NGINX_PORT=8999
HISDATA_DB_NAME=ek_patient
HISDATA_DB_PASSWORD=ek_patient123
HISDATA_PORT=9704
JVM_OPT=-Xms1024m -Xmx1024m
MANAGER_DB_NAME=ek_manager
MANAGER_DB_PASSWORD=ek_manager123
MANAGER_EXECUTOR_PORT=9777
MANAGER_PORT=9700
NURSE_DB_NAME=ek_nurse
NURSE_DB_PASSWORD=ek_nurse123
NURSE_PORT=9702
#PATIENTSERVER_DB_NAME=ek_patient
#PATIENTSERVER_PORT=9708
#RASS_DB_NAME=ek_rass
#RASS_PORT=9801
RULE_DB_NAME=ek_rule
RULE_DB_PASSWORD=ek_rule123
RULE_PORT=9502
#TRAIN_DB_NAME=ek_train
#TRAIN_PORT=9705
CA_DB_NAME=ek_ca
CA_PORT=9709
HIS_DB_NAME=ginterface
HIS_DB_PASSWORD=ginterface
HIS_PORT=10000
EMRQC_DB_NAME=ek_emr
EMRQC_DB_PASSWORD=ek_emr123
EMRQC_PORT=9710
EMRQC_EXECUTOR_PORT=9711
# [busi] end

# [eking] start
ANALYSIS_DB_NAME=ek_analysis
ANALYSIS_DB_PASSWORD=ek_analysis123
ANALYSIS_PORT=10088
APP_ACTIVE=pro
APP_NACOS_NAMESPACE=
APP_NACOS_SERVER_ADDR=192.168.1.231:8848
AUTHSERVER_DB_NAME=ek_sys
AUTHSERVER_DB_PASSWORD=ek_sys123
AUTHSERVER_PORT=9600
#COMP_MANAGER_PORT=10701
DOCKER_HOST_ADDR=192.168.1.231
GATEWAY_PORT=9443
GATEWAY_PORT2=8720
JVM_OPT=-Xms1024m -Xmx1024m
NOTICE_DB_NAME=ek_notice
NOTICE_DB_PASSWORD=ek_notice123
NOTICE_PORT=10620
OSS_DB_NAME=ek_oss
OSS_DB_PASSWORD=ek_oss123
OSS_PORT=10600
SYS_DB_NAME=ek_sys
SYS_DB_PASSWORD=ek_sys123
SYS_PORT=9500
TIMER_DB_NAME=ek_timer
TIMER_DB_PASSWORD=ek_timer123
TIMER_PORT=10720
#XPS2PDF_PORT=15000
# [eking] end

# [mysql] start
MYSQL_PORT=3306
MYSQL_ROOT_PASSWORD=Ekinghis@jsxy2021
# [mysql] end

# [nacos] start
NACOS_MYSQL_DB_NAME=ek_nacos
NACOS_MYSQL_HOST=192.168.1.231
NACOS_MYSQL_PASSWORD=Ekinghis@jsxy2021
NACOS_MYSQL_PORT=3306
NACOS_MYSQL_USERNAME=eking
NACOS_PORT=8848
# [nacos] end

# [rabbitmq] start
RABBITMQ_DEFAULT_PASS=newhis
RABBITMQ_DEFAULT_USER=newhis
RABBITMQ_DEFAULT_VHOST=scloud-release
RABBITMQ_PORT1=5672
RABBITMQ_PORT2=15672
# [rabbitmq] end

# [redis] start
REDIS_PORT=6379
# [redis] end

# [scloud_nginx] start
DOCKER_HOST_ADDR=192.168.1.231
SLOUD_NGINX_PORT=4431
# [scloud_nginx] end

# [sentinel] start
SENTINEL_PORT=8900
# [sentinel] end

# [xxl-job] start
XXL_JOB_MYSQL_DB_NAME=xxl_job
XXL_JOB_MYSQL_HOST=192.168.1.231
XXL_JOB_MYSQL_PASSWORD=Ekinghis@jsxy2021
XXL_JOB_MYSQL_PORT=3306
XXL_JOB_MYSQL_USERNAME=eking
XXL_JOB_PORT=26000
# [xxl-job] end

# [weedfs_standalone] start
WEED_MASTER1_IP=192.168.1.231
WEED_MASTER1_PORT=9333
WEED_VOLUMN1_1_PORT=9381
# [weedfs_standalone] end

# [weedfs1] start
WEED_MASTER1_IP=192.168.1.231
WEED_MASTER1_PORT=9333
WEED_VOLUMN1_1_PORT=9381
WEED_VOLUMN1_2_PORT=9382
WEED_VOLUMN1_3_PORT=9383
# [weedfs1] end

# [weedfs2] start
WEED_MASTER1_IP=192.168.1.231
WEED_MASTER1_PORT=9333
WEED_MASTER2_IP=192.168.1.231
WEED_VOLUMN2_1_PORT=9481
WEED_VOLUMN2_2_PORT=9482
WEED_VOLUMN2_3_PORT=9483
# [weedfs2] end

```

### 3. 启动中间件

中间件服务及启动顺序：mysql，seaweedfs -> nacos，xxl-job -> rabbitmq，redis，scloud_nginx，sentinel

```shell
# 创建docker虚拟网段
# create_network.sh
docker network create --driver=bridge --subnet=188.66.20.0/24 --gateway=188.66.20.1 sshapp-scloud
```

```shell
# nacos目录下docker-compose.yaml
version: "2.0"

networks:
    sshapp-scloud:
        external:
            name: sshapp-scloud

services:
    nacos:
        #        container_name: nacos
        hostname: nacos
        image: one/java:8
        env_file:
            - ./environment.env
            - ./.env
        environment:
            NACOS_MYSQL_HOST: ${NACOS_MYSQL_HOST}
            NACOS_MYSQL_PORT: ${NACOS_MYSQL_PORT}
            NACOS_MYSQL_DB_NAME: ${NACOS_MYSQL_DB_NAME}
            NACOS_MYSQL_USERNAME: ${NACOS_MYSQL_USERNAME}
            NACOS_MYSQL_PASSWORD: ${NACOS_MYSQL_PASSWORD}
        networks:
            - sshapp-scloud
        volumes:
            - ./nacos_app:/workspace:rw
        privileged: true
        ports:
            - "${NACOS_PORT}:8848"
        working_dir: /workspace
        command: java -server -Xms512m -Xmx512m -jar -Dnacos.standalone=true nacos-server.jar

```

其他中间件省略说明

### 4. 启动 eking 基础服务

```shell
# eking目录下docker-compose.yaml
version: "2.0"

networks:
    eking-network:
        driver: bridge

services:
    authserver:
        container_name: authserver
        image: one/java:8
        networks:
            - eking-network
        env_file:
            - ./environment.env
            - ./.env
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${AUTHSERVER_PORT}
            APP_DB_NAME: ${AUTHSERVER_DB_NAME}
        volumes:
            - ./apps/authserver:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        privileged: true
        mem_limit: 4g
        ports:
            - "${AUTHSERVER_PORT}:9600"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-authserver.jar --spring.profiles.active=${APP_ACTIVE}

    sys:
        container_name: sys
        image: one/java:8
        env_file:
            - ./environment.env
            - ./.env
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${SYS_PORT}
            APP_DB_NAME: ${SYS_DB_NAME}
        networks:
            - eking-network
        volumes:
            - ./apps/sys:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        privileged: true
        mem_limit: 4g
        ports:
            - "${SYS_PORT}:9500"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-sys.jar --spring.profiles.active=${APP_ACTIVE}

    gateway:
        container_name: gateway
        image: one/java:8
        networks:
            - eking-network
        env_file:
            - ./environment.env
            - ./.env
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${GATEWAY_PORT}
        volumes:
            - ./apps/gateway:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        privileged: true
        mem_limit: 4g
        ports:
            - "${GATEWAY_PORT}:9443"
            - "${GATEWAY_PORT2}:8720"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -Dcsp.sentinel.api.port=8720 -Dcsp.sentinel.heartbeat.interval.ms=10000 -Dcsp.sentinel.log.use.pid=true -Dcsp.sentinel.app.type=1 -jar sshapp-gateway.jar --spring.profiles.active=${APP_ACTIVE}

    oss:
        container_name: oss
        image: one/java:8
        networks:
            - eking-network
        env_file:
            - ./environment.env
            - ./.env
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${OSS_PORT}
            APP_DB_NAME: ${OSS_DB_NAME}
        volumes:
            - ./apps/oss:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        privileged: true
        mem_limit: 4g
        ports:
            - "${OSS_PORT}:10600"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-oss.jar --spring.profiles.active=${APP_ACTIVE}

    analysis:
        container_name: analysis
        image: one/java:8
        networks:
            - eking-network
        env_file:
            - ./environment.env
            - ./.env
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${ANALYSIS_PORT}
            APP_DB_NAME: ${ANALYSIS_DB_NAME}
        volumes:
            - ./apps/analysis:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        privileged: true
        mem_limit: 4g
        ports:
            - "${ANALYSIS_PORT}:10088"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-analysis.jar --spring.profiles.active=${APP_ACTIVE}

    comp-manager:
        container_name: comp-manager
        image: one/java:8
        networks:
            - eking-network
        env_file:
            - ./environment.env
            - ./.env
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${COMP_MANAGER_PORT}
        volumes:
            - ./apps/comp-manager:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        privileged: true
        mem_limit: 4g
        ports:
            - "${COMP_MANAGER_PORT}:10700"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-comp-manager.jar --spring.profiles.active=${APP_ACTIVE}

    notice:
        container_name: notice
        image: one/java:8
        networks:
            - eking-network
        env_file:
            - ./environment.env
            - ./.env
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${NOTICE_PORT}
            APP_DB_NAME: ${NOTICE_DB_NAME}
        volumes:
            - ./apps/notice:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        privileged: true
        mem_limit: 4g
        ports:
            - "${NOTICE_PORT}:10620"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-notice.jar --spring.profiles.active=${APP_ACTIVE}

    timer:
        container_name: timer
        image: one/java:8
        networks:
            - eking-network
        env_file:
            - ./environment.env
            - ./.env
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${TIMER_PORT}
            APP_DB_NAME: ${TIMER_DB_NAME}
        volumes:
            - ./apps/timer:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        privileged: true
        mem_limit: 4g
        ports:
            - "${TIMER_PORT}:10720"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-timer.jar --spring.profiles.active=${APP_ACTIVE}

    xps2pdf:
        container_name: xps2pdf
        image: xps2pdf:1.2
        networks:
            - eking-network
        privileged: true
        mem_limit: 4g
        environment:
            SCLOUD_NGINX: ${SCLOUD_NGINX}
        volumes:
            - ./xps2pdf/config.py:/xps2pdf/config.py
            - ./xps2pdf/xps2pdf.py:/xps2pdf/app/xps2pdf.py
        ports:
            - "${XPS2PDF_PORT}:5000"
```

### 5. 启动 busi 业务服务

```shell
# busi目录下docker-compose.yaml
version: '2.1'

networks:
    sshapp-scloud:
        external:
            name: sshapp-scloud

services:
    nginx:
        image: one/nginx:1.12
        networks:
            - sshapp-scloud
        volumes:
            - ./nginx/conf:/etc/nginx:ro
            - ./nginx/logs:/var/log/nginx
            - ./nginx/www:/usr/share/nginx/html
            - ./nginx/workspace:/app
        env_file:
            - ./environment.env
            - ./.env
        privileged: true
        mem_limit: 4g
        ports:
            - "${FRONT_NGINX_PORT}:80"

    manager:
        image: one/java:8
        sysctls:
            net.ipv4.ip_local_port_range: "1024 65000"
        networks:
            - sshapp-scloud
        volumes:
            - ./apps/manager:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        env_file:
            - ./environment.env
            - ./.env
        #      restart: unless-stopped
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${MANAGER_PORT}
            APP_DB_NAME: ${MANAGER_DB_NAME}
        privileged: true
        mem_limit: 4g
        ports:
            - "${MANAGER_PORT}:9700"
            - "${MANAGER_EXECUTOR_PORT}:9777"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-manager.jar --spring.profiles.active=${APP_ACTIVE}

    emr:
        image: one/java:8
        sysctls:
            net.ipv4.ip_local_port_range: "1024 65000"
        hostname: emr
        networks:
            - sshapp-scloud
        volumes:
            - ./apps/emr:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        env_file:
            - ./environment.env
            - ./.env
        #      restart: unless-stopped
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${EMR_PORT}
            APP_DB_NAME: ${EMR_DB_NAME}
        privileged: true
        mem_limit: 4g
        ports:
            - "${EMR_PORT}:9703"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-emr.jar --spring.profiles.active=${APP_ACTIVE}

    nurse:
        image: one/java:8
        sysctls:
            net.ipv4.ip_local_port_range: "1024 65000"
        hostname: nurse
        networks:
            - sshapp-scloud
        volumes:
            - ./apps/nurse:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        env_file:
            - ./environment.env
            - ./.env
        #      restart: unless-stopped
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${NURSE_PORT}
            APP_DB_NAME: ${NURSE_DB_NAME}
        privileged: true
        mem_limit: 4g
        ports:
            - "${NURSE_PORT}:9702"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-nurse.jar --spring.profiles.active=${APP_ACTIVE}

    hisdata:
        image: one/java:8
        sysctls:
            net.ipv4.ip_local_port_range: "1024 65000"
        hostname: hisdata
        networks:
            - sshapp-scloud
        volumes:
            - ./apps/hisdata:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        env_file:
            - ./environment.env
            - ./.env
        #      restart: unless-stopped
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${HISDATA_PORT}
            APP_DB_NAME: ${HISDATA_DB_NAME}
        privileged: true
        mem_limit: 4g
        ports:
            - "${HISDATA_PORT}:9704"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-hisdata.jar --spring.profiles.active=${APP_ACTIVE}

    patientServer:
        image: one/java:8
        sysctls:
            net.ipv4.ip_local_port_range: "1024 65000"
        hostname: patientServer
        networks:
            - sshapp-scloud
        volumes:
            - ./apps/patientServer:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        env_file:
            - ./environment.env
            - ./.env
        #      restart: unless-stopped
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${PATIENTSERVER_PORT}
            APP_DB_NAME: ${PATIENTSERVER_DB_NAME}
        privileged: true
        mem_limit: 4g
        ports:
            - "${PATIENTSERVER_PORT}:9706"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-patientServer.jar --spring.profiles.active=${APP_ACTIVE}

    rule:
        image: one/java:8
        sysctls:
            net.ipv4.ip_local_port_range: "1024 65000"
        hostname: rule
        networks:
            - sshapp-scloud
        volumes:
            - ./apps/rule:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        env_file:
            - ./environment.env
            - ./.env
        #      restart: unless-stopped
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${RULE_PORT}
            APP_DB_NAME: ${RULE_DB_NAME}
        privileged: true
        mem_limit: 4g
        ports:
            - "${RULE_PORT}:9502"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-rule.jar --spring.profiles.active=${APP_ACTIVE}

    ca:
        image: one/java:8
        sysctls:
            net.ipv4.ip_local_port_range: "1024 65000"
        hostname: command
        networks:
            - sshapp-scloud
        volumes:
            - ./apps/ca:/workspace:rw
            - ./conf/_common/bootstrap-${APP_ACTIVE}.properties:/workspace/config/bootstrap-${APP_ACTIVE}.properties:rw
        env_file:
            - ./environment.env
            - ./.env
        #      restart: unless-stopped
        environment:
            DOCKER_HOST_ADDR: ${DOCKER_HOST_ADDR}
            APP_NACOS_NAMESPACE: ${APP_NACOS_NAMESPACE}
            APP_NACOS_SERVER_ADDR: ${APP_NACOS_SERVER_ADDR}
            DISCOVERY_PORT: ${CA_PORT}
            APP_DB_NAME: ${CA_DB_NAME}
        privileged: true
        mem_limit: 4g
        ports:
            - "${CA_PORT}:9709"
        working_dir: /workspace
        command: java -server ${JVM_OPT} -jar sshapp-ca.jar --spring.profiles.active=${APP_ACTIVE}
```
