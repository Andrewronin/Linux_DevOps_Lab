FROM centos
RUN yum install -y epel-release && \
    yum -y update  && \
    yum install -y nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

