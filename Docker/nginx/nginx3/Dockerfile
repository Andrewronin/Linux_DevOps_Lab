FROM alpine
RUN apk update  && \
    apk add nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

