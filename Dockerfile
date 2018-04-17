FROM registry.cn-hangzhou.aliyuncs.com/mustanggu/node:8.9.1-alpine-pm2
RUN mkdir -p /opt/oracle
WORKDIR /opt/oracle 
COPY basic.zip ./
COPY sdk.zip ./
RUN apk update \
	&& apk add --no-cache python gcc \
	&& unzip basic.zip \
	&& unzip sdk.zip \
	&& rm basic.zip \
	&& rm sdk.zip \
	&& mv instantclient_12_2 instantclient \
	&& ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INC_DIR=/opt/oracle/instantclient/sdk/include