FROM centos:latest
ENV TERM dumb
ENV PATH $PATH:/usr/local/node/bin
ENV PATH=$PATH:/usr/local/node/bin
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INC_DIR=/opt/oracle/instantclient/sdk/include

WORKDIR /usr/local
COPY node-v8.11.1-linux-x64.tar.xz ./
RUN tar -xvf node-v8.11.1-linux-x64.tar.xz \
	&& rm node-v8.11.1-linux-x64.tar.xz \
	&& mv node-v8.11.1-linux-x64 node \
	&& npm config set registry https://registry.npm.taobao.org \
	&& npm i -g yarn \
	&& mkdir -p /opt/oracle \
	&& yum update \
	&& yum install python gcc unzip libaio -y
WORKDIR /opt/oracle 
COPY basic.zip ./
COPY sdk.zip ./
RUN unzip basic.zip \
	&& unzip sdk.zip \
	&& rm basic.zip \
	&& rm sdk.zip \
	&& mv instantclient_12_2 instantclient \
	&& ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so
