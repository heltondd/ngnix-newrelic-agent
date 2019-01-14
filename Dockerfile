FROM buildpack-deps:jessie-curl

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo 'deb http://nginx.org/packages/mainline/debian/ jessie nginx' >> /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y nginx-nr-agent && \
    rm -rf /var/lib/apt/lists/*

ENV NEWRELIC_LICENSE ''
ENV NEWRELIC_APP     ''
ENV NGINX_STATUS_URL ''

COPY nginx-nr-agent.ini /etc/nginx-nr-agent/nginx-nr-agent.ini
COPY nginx-nr-agent.sh /opt/

ENTRYPOINT [ "/opt/nginx-nr-agent.sh" ]