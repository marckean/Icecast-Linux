FROM alpine:3.6
ENV ICECAST_VERSION 2.4.3
RUN \
	mkdir /data/ &&\
	#mkdir ./log/ &&\
	#mkdir ./web/ &&\
	#mkdir ./admin/ &&\
	#chown 9999 ./log &&\
	#chown 9999 ./web &&\
	#chown 9999 ./admin &&\
	#chmod 777 ./log &&\
	#chmod 777 ./web &&\
	#chmod 777 ./data &&\
	apk --update add build-base file libssl1.0 openssl-dev libxslt libxslt-dev libvorbis \
		libvorbis-dev opus opus-dev libogg libogg-dev speex speex-dev libtheora \
		libtheora-dev curl curl-dev &&\
# Download, compile and install Icecast
	curl https://ftp.osuosl.org/pub/xiph/releases/icecast/icecast-${ICECAST_VERSION}.tar.gz |\
	#curl http://downloads.xiph.org/releases/icecast/icecast-${ICECAST_VERSION}.tar.gz |\
	tar xz -C /tmp &&\
	cd /tmp/icecast-${ICECAST_VERSION} &&\
	./configure --enable-static &&\
	make &&\
	make install &&\
	apk del build-base file openssl-dev libxslt-dev libvorbis-dev opus-dev libogg-dev \
		speex-dev libtheora-dev curl-dev &&\
	cd $HOME &&\
	rm -rf /tmp/* /var/cache/apk/* &&\
	addgroup -g 9999 icecast &&\
	adduser -S -D -H -u 9999 -G icecast -s /bin/false icecast &&\
	mkdir /usr/local/share/icecast/log/ &&\
	chown 9999 /usr/local/share/icecast/*

COPY ./data/icecast.xml /data/icecast.xml
ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

USER 9999
ENTRYPOINT [ "dumb-init" ]
CMD [ "icecast", "-c", "/data/icecast.xml" ]
EXPOSE 8000