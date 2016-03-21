FROM jdeathe/centos-ssh:centos-7

RUN yum -y install \
    automake \
    fuse-devel \
    gcc-c++ \
    git \
    libcurl-devel \
    libxml2-devel \
    make \
    openssl-devel \
    && rm -rf /var/cache/yum/* \
    && yum clean all \
    && git clone https://github.com/s3fs-fuse/s3fs-fuse

WORKDIR s3fs-fuse
RUN ./autogen.sh && ./configure --prefix=/usr --with-openssl && make && make install
WORKDIR /
ADD mount-s3.sh /mount-s3.sh
RUN rm -rf /s3fs-fuse && chmod +x /mount-s3.sh
ADD s3fs.conf /etc/services-config/supervisor/supervisord.d/s3fs.conf
