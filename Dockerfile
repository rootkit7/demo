FROM alpine:latest

# some tools
RUN apk add --no-cache --update  \
    curl \
    jq \
    dash \
    sudo \
    su-exec \
    unzip \
    nmap
    
    
WORKDIR /tools
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && chmod +x kubectl
#COPY kubectl.zip /tools	

RUN adduser -D test01 && adduser test01 test01
RUN adduser -D 1000560000 && adduser 1000560000 1000560000 
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && echo "ALL ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/test01 \
&& echo "ALL ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/1000560000 && chmod 0440 /etc/sudoers.d/test01 && chmod 0440 /etc/sudoers.d/1000560000 && echo "Set disable_coredump false" >> /etc/sudo.conf
#Set disable_coredump false


USER test01
#CMD ["/bin/zsh"]
ENTRYPOINT ["sh"]
