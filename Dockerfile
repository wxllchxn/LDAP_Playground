FROM node:12

COPY pack server

ENV TZ=Asia/Taipei

RUN cd /server \
#  && npm install \
 && apt-get update \
 && apt-get install -y \
        ldap-utils \
        vim

WORKDIR /server
CMD ["sleep", "infinity"]