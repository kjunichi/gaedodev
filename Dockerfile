FROM ubuntu:14.04
MAINTAINER Junichi Kajiwara<junichi.kajiwara@gmail.com>

ENV GAESDKURL https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-1.9.6.zip

RUN apt-get update
RUN apt-get install -y curl git bzr mercurial unzip

RUN curl -s https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz| tar -v -C /usr/local/ -xz
ENV PATH  /usr/local/go/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
ENV GOPATH  /go
ENV GOROOT  /usr/local/go
ENV HOME /root

# Define working directory.
WORKDIR /root
ENV PATH $PATH:$GOPATH/bin

RUN go get github.com/peco/peco/cmd/peco
RUN curl -s $GAESDKURL > /tmp/gae.zip
RUN cd /usr/local && unzip /tmp/gae.zip
ENV PATH /usr/local/go_appengine:$PATH

RUN apt-get install -y python-dev python-pip
RUN pip install PIL --allow-external PIL --allow-unverified PIL

EXPOSE 8080

RUN apt-get install -y openssh-server
RUN /etc/init.d/ssh start
RUN /etc/init.d/ssh stop

RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

ENV ROOTPASSWORD golang123
RUN echo "root:${ROOTPASSWORD}" |chpasswd

RUN echo "export GOPATH=/go" >>/root/.bashrc
RUN echo "export GOROOT=/usr/local/go" >>/root/.bashrc
RUN echo "export PATH=/usr/local/go_appengine:$GOPATH/bin:$PATH" >>/root/.bashrc

#node.js for HTML5
RUN wget git.io/nodebrew
RUN sudo -uroot chown root nodebrew
RUN sudo -uroot perl nodebrew setup
ENV PATH $HOME/.nodebrew/current/bin:$PATH
RUN echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >>/root/.bashrc
RUN nodebrew install-binary stable
RUN nodebrew use latest
RUN npm install -g gulp
RUN npm install -g bower
RUN npm install -g browserify

CMD /usr/sbin/sshd -D
EXPOSE 22
