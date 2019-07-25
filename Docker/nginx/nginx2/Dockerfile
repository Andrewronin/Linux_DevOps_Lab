FROM ubuntu
RUN apt-get -y update  && \
    apt-get install -y nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

