## 说明
#### 镜像构建
 - 本地构建
	 ```
	  docker build -t odoo12:v1 .
	 ```
 - 直接用 Git repo 进行构建
	 ```
	 odoo12镜像：
	  docker build -t odoo12:v1 https://github.com/redhead520/dockerOdoo.git#:12.0
	odoo13镜像：
	  docker build -t odoo13:v1 https://github.com/redhead520/dockerOdoo.git#:13.0
	 ```

#### 启动镜像
```
docker run -it --name shop_mall \
--restart=always --restart=on-failure:1 \
-p 8066:8069 -p 8062:8072 \
--mount type=bind,source=/home/odoodev/odoo12,target=/odoo,readonly \
--mount type=bind,source=/home/odoodev/oe_shop/data,target=/odoo_data \
-v /home/odoodev/oe_shop/odoo_shop_mall:/odoo_product_addons \
ubuntu:16.04 /bin/bash 
```
```
docker run -it --name shop_mall \
--restart=always --restart=on-failure:1 \
-p 8066:8069 -p 8062:8072 \
-v /home/odoodev/odoo12:/odoo \
-v /home/odoodev/oe_shop/data:/odoo_data \
-v /home/odoodev/oe_shop/odoo_shop_mall:/odoo_product_addons \
ubuntu:16.04 /bin/bash 
```

```
docker run -it --name odoo12 \
--restart=always --restart=on-failure:1 \
-p 8000:8069 -p 8002:8072 -p 54325:5432 \
--mount type=bind,source=/Users/afa/code/odoo/odoo12,target=/odoo,readonly \
--mount type=bind,source=/Users/afa/code/odoo/odoo12_data_docker,target=/odoo_data \
-v /Users/afa/code/odoo/gzlsd_addons:/odoo_product_addons \
odoo12:v1 /bin/bash
```
```
docker run -it --name odoo12 --restart=always --restart=on-failure:1 -p 8000:8069 -p 8002:8072 -p 54320:5432 \
--mount type=bind,source=/opt/code/odoo12,target=/odoo,readonly \
--mount type=bind,source=/opt/code/abc/data,target=/odoo_data \
-v /opt/code/abc/afa_wool:/odoo_product_addons \
odoo12:v1 /bin/bash
```

#### 进入容器
```
docker exec -it odoo12 /bin/bash
```
#### 停止运行容器
```
docker stop odoo12
```
#### 启动容器
```
docker start odoo12
```

#### 删除容器
```
docker rm odoo12
```

#### 删除镜像
```
删除所有仓库名为 odoo12 的镜像
docker image rm $(docker image ls -q odoo12)
或者
docker rmi odoo12
```