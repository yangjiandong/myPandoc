虚拟服务器配置
====

218 供应商平台
----

虚机部署在`192.168.1.201`

- no`pc8`
- user:`administrator`,pass:`hrp@eking.com`

### 192.168.1.218

- user:`ekman`,pass:`123@ek.com`
- user:`root`,pass:`hcost@ek.com`
- user:`ek2`,pass:`123@ek.com`

### tomcat

- `http://192.168.1.218:8080/supapp`
- path:`/home/ekman/apache-tomcat-7.0.54`

### 开机步骤

### logs

注意，产生的log文件在`/logs`

svn 服务器
---

### 192.168.1.203

- user:`administrator`,pass:`svn@ek.com`
- `http://192.168.1.203/svn`

nginx 服务器
---

虚机部署在`192.168.1.203`

### 192.168.1.211

- user:`root`,pass:`jira@ek.com`
- nginx:`/etc/nginx`
- 操作
    - 重启 `nginx -s reload`

jira问题单系统
---

虚机部署在`192.168.1.203`

### 192.168.1.219

- user:`root`,pass:`jira6@ek.com`
- jira 启动操作 `cd /home/jira/atlassian-jira-6.3.6-standalone/bin, ./start-jira.sh`

### 217 fastdfs 备份

- fastdfs 安装路径 `/root/` or `cd ` 直接进入 `root` 用户目录, `/root/fastdfs`
- 启动 `./run_fastdfs_storge.sh`

    因为只是 `217` 的备份，所以只需启动 storge

- 备份 `cd fastdfs.backup, tar czvf mmdd.tar.gz ../fastdfs`

217 fastdfs 服务器
---

虚机部署在`192.168.1.204`, no `pc2`

- user:`administrator`, pass:`cpb@eking.com`

### 192.168.1.217

- user:`root`,pass:`123@ek.com`
- fastdfs 安装 `/root/fastdfs`, 启动
    - tracker `./run_fastdfs_tracker.sh`
    - storage `./run_fastdfs_storage.sh`
- fastdfs config: `/etc/fdfs/tracker.conf, storage.conf`

213 测试服务器
---

虚机部署在`192.168.1.205`, no `pc1`

- user:`administrator`, pass:`admin@123`

### 192.168.1.213

- user:`root`,pass:`hcost@ek.com`
- fastdfs 测试库, `/root/fastdfs`
- 供应商测试, `/home/supplier/apache-tomcat-suppliers`
- 仓库warehouse,sys,con,ebiao `/home/ekman/apache-tomcat7.0.54.warhouse`
- nginx(openresty-run), `/root/openresty-run`
    - start,`cd openresty-run, ./start_nginx.sh`
    - reload, `cd openresty-run, ./reload_nginx.sh`
- 财经fa, `/home/ekman/apache-tomcat-7.0.54`

### 192.168.1.212

服务器分配
---

| no | 服务器 | vm |
| ----- | ----- | ----- |
| pc8 | 192.168.1.201 | 192.168.1.218 |
| pc8 | 192.168.1.201 | 192.168.1.218 |


| 项目        | 价格   |  数量  |
| --------   | -----:  | :----:  |
| 计算机     | $1600 |   5     |
| 手机        |   $12   |   12   |
| 管线        |    $1    |  234  |


