FROM ministryofjustice/ruby:2.5.1

# Ensure the pdftk package is installed as a prereq for ruby PDF generation
ENV DEBIAN_FRONTEND noninteractive

# SSH proxy settings
ENV SSH_AUTH_SOCK /tmp/ssh-auth
ENV SSH_AUTH_PROXY_PORT 1234

# install runit, nodejs and pdftk
RUN apt-get update && apt-get install -y runit unzip zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

RUN mkdir -p /usr/src/app
RUN bundle config --global without test:development
WORKDIR /usr/src/app

COPY . /usr/src/app

RUN bundle install

RUN wget https://github.com/papertrail/remote_syslog2/releases/download/v0.20/remote-syslog2_0.20_amd64.deb
RUN dpkg -i remote-syslog2_0.20_amd64.deb
RUN remote_syslog \
  -p 20568 \
  -d logs7.papertrailapp.com \
  --pid-file=/var/run/remote_syslog.pid \
  --hostname=$PAPERTRAIL_NAME-$HOSTNAME \
  /usr/src/app/log/production.log

EXPOSE 8080

CMD ["./run.sh"]
