FROM ubuntu:16.04
ENV LANG C.UTF-8
VOLUME ["/odoo", "/odoo_data", "/odoo_product_addons"]
COPY requirements.txt /opt/
COPY wkhtmltox_0.12.5-1.bionic_amd64.deb /opt/
COPY pip.conf /root/.pip/
COPY odoo.conf /opt/
COPY start.sh /opt/
COPY stop.sh /opt/
COPY restart.sh /opt/
COPY sources.list /etc/apt/

# Prevent tzdata apt-get installation from asking for input.
ENV DEBIAN_FRONTEND=noninteractive

# Install some deps, lessc and less-plugin-clean-css
# xenial / bionic / focal 分别对应ubuntu的16.04,18.04,20.04
RUN find /etc/apt -name sources.list | xargs sed -i 's/bionic/xenial/g' && \
    apt-get update && apt-get -y upgrade && \
    apt-get -y install clang-format cloc cmake cppcheck doxygen g++ git graphviz flex lcov mpich python3-pip qt5-default valgrind vim-common tzdata autoconf automake libtool perl ttf-wqy-zenhei ttf-wqy-microhei curl && \
    apt-get -y install npm node-less && npm install -g less && \
    apt-get -y autoremove && apt-get clean all 

#Install wkhtmltopdf
RUN dpkg --force-depends -i /opt/wkhtmltox_0.12.5-1.bionic_amd64.deb  && apt-get update && apt-get -y install -f --no-install-recommends
# COPY ./simsun.ttc /usr/share/fonts

# 默认Python2调整为Python3 并且 安装odoo 依赖环境
# 或者安装python3.6.5: wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2 100 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 200
RUN apt-get install -y libpq-dev libxml2-dev libxslt1-dev libffi-dev libsasl2-dev python-dev libldap2-dev libssl-dev libevent-dev && \
    pip3 install -r /opt/requirements.txt -i https://pypi.douban.com/simple/

# 更新最新的postgresql安装源 当前为psql12  LSB_RELEASE变量为 xenial / bionic / focal （$(lsb_release -cs)）
# wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
# 安装数据库，ubuntu的16.04,18.04,20.04版本的默认psql版本分别为9.x、10.x，12.x）
# /usr/lib/postgresql/10/bin/pg_ctl -D /var/lib/postgresql/10/main -l logfile start
# \password;  postgres

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && apt-get update && \
    apt-get install -y postgresql && apt-get -y autoremove && apt-get clean all && \
    find /etc/postgresql -name pg_hba.conf | xargs sed -i 's/127.0.0.1\/32/0.0.0.0\/0/g' && \
    find /etc/postgresql -name pg_hba.conf | xargs sed -i 's/md5/trust/g' && \
    find /etc/postgresql -name pg_hba.conf | xargs sed -i 's/peer/trust/g' && \
    find /etc/postgresql -name postgresql.conf | xargs sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" && \
    /etc/init.d/postgresql restart && \
    psql -U postgres -c "CREATE ROLE odoo WITH LOGIN SUPERUSER CREATEDB CREATEROLE INHERIT REPLICATION CONNECTION LIMIT -1 PASSWORD 'odoo'"

EXPOSE 5432
EXPOSE 8069
EXPOSE 8072
WORKDIR /opt

# Set OS timezone to China
# RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Set Odoo timezone to China (will be set at startup thanks to Odoo parameter substitution)
# ENV ODOO_TIMEZONE=Asia/Shanghai

LABEL org.opencontainers.image.created="2019-11-20T23:00:04.820549"
LABEL org.opencontainers.image.url="https://github.com/redhead520"
LABEL org.opencontainers.image.authors="afa <jxhuanghf@gmail.com>"
LABEL org.opencontainers.image.documentation="https://github.com/redhead520/dockerOdoo.git"
LABEL org.opencontainers.image.source="https://github.com/redhead520/dockerOdoo.git"
LABEL org.opencontainers.image.version="12.0"
LABEL org.opencontainers.image.vendor="ArcheTI"
LABEL org.opencontainers.image.ref.name="12.0"
LABEL org.opencontainers.image.title="Odoo 12.0"
LABEL org.opencontainers.image.description="Full featured odoo image that make odoo deployment fun and secure."