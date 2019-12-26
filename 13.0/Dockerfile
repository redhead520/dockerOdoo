FROM ubuntu:18.04
ENV LANG C.UTF-8
VOLUME ["/odoo", "/odooData", "/productAddons"]
COPY requirements.txt /opt/
COPY wkhtmltox_0.12.5-1.bionic_amd64.deb /opt/
COPY sources.list /etc/apt/
COPY pip.conf ~/.pip/

# start
# Prevent tzdata apt-get installation from asking for input.
ENV DEBIAN_FRONTEND=noninteractive

# Install some deps, lessc and less-plugin-clean-css
RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install clang-format cloc cmake cppcheck doxygen g++ git graphviz flex lcov mpich python3-pip qt5-default valgrind vim-common tzdata autoconf automake libtool perl npm node-less ttf-wqy-zenhei ttf-wqy-microhei curl && \
    apt-get -y autoremove && apt-get clean all 

#Install wkhtmltopdf
RUN dpkg --force-depends -i /opt/wkhtmltox_0.12.5-1.bionic_amd64.deb  && apt-get update && apt-get -y install -f --no-install-recommends
# COPY ./simsun.ttc /usr/share/fonts

# 默认Python2调整为Python3 并且 安装odoo 依赖环境
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2 100 && update-alternatives --install /usr/bin/python python /usr/bin/python3 200
RUN apt-get install -y libpq-dev libxml2-dev libxslt1-dev libffi-dev libsasl2-dev python-dev libldap2-dev libssl-dev libevent-dev && \
    pip3 install -r /opt/requirements.txt -i https://pypi.douban.com/simple/
EXPOSE 8069
WORKDIR /odoo

# Set OS timezone to China
# RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Set Odoo timezone to China (will be set at startup thanks to Odoo parameter substitution)
# ENV ODOO_TIMEZONE=Asia/Shanghai

LABEL org.opencontainers.image.created="2019-11-20T23:00:04.820549"
LABEL org.opencontainers.image.url="https://github.com/redhead520"
LABEL org.opencontainers.image.authors="afa <jxhuanghf@gmail.com>"
LABEL org.opencontainers.image.documentation="https://github.com/llacroix/odoo-docker"
LABEL org.opencontainers.image.source="https://github.com/llacroix/odoo-docker"
LABEL org.opencontainers.image.version="12.0"
LABEL org.opencontainers.image.vendor="ArcheTI"
LABEL org.opencontainers.image.ref.name="12.0"
LABEL org.opencontainers.image.title="Odoo 12.0"
LABEL org.opencontainers.image.description="Full featured odoo image that make odoo deployment fun and secure."