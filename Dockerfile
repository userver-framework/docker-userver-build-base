ARG ARCH=
FROM ${ARCH}/debian:bullseye-slim

# Set current timezone
RUN echo "Europe/Moscow" > /etc/timezone
RUN ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

ENV DEBIAN_FRONTEND noninteractive
ENV CMAKE_OPTS "-DUSERVER_FEATURE_MONGODB=OFF -DUSERVER_FEATURE_CLICKHOUSE=OFF"

RUN apt-get update

RUN apt-get install -y --allow-unauthenticated \
    binutils-dev \
    build-essential \
    ccache \
    chrpath \
    clang-9 \
    clang-format-9 \
    clang-tidy-9 \
	cmake \
	libboost1.74-dev \
	libboost-program-options1.74-dev \
	libboost-filesystem1.74-dev \
	libboost-locale1.74-dev \
	libboost-regex1.74-dev \
	libboost-iostreams1.74-dev \
	libev-dev \
	zlib1g-dev \
	libcurl4-openssl-dev \
	curl \
	libcrypto++-dev \
	libyaml-cpp-dev \
	libssl-dev \
	libfmt-dev \
	libcctz-dev \
	libhttp-parser-dev \
	libjemalloc-dev \
	libmongoc-dev \
	libbson-dev \
	libldap2-dev \
	libpq-dev \
	postgresql-server-dev-13 \
	libkrb5-dev \
	libhiredis-dev \
	libgrpc-dev \
	libgrpc++-dev \
	libgrpc++1 \
	protobuf-compiler-grpc \
	libprotoc-dev \
	python3-dev \
	python3-protobuf \
	python3-jinja2 \
	python3-virtualenv \
	virtualenv \
	python3-voluptuous \
	python3-yaml \
	libc-ares-dev \
	libspdlog-dev \
	libbenchmark-dev \
	libgmock-dev \
	libgtest-dev \
	ccache \
	git \
	postgresql-13 \
	redis-server \
	vim \
	sudo \
	gnupg2 \
	wget \
	dirmngr \
	postgresql-common \
	locales

RUN apt-get clean all

# Generating locale
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
RUN echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc
RUN echo "export LANG=en_US.UTF-8" >> ~/.bashrc
RUN echo "export LANGUAGE=en_US.UTF-8" >> ~/.bashrc

RUN locale-gen ru_RU.UTF-8
RUN locale-gen en_US.UTF-8
RUN echo LANG=en_US.UTF-8 >> /etc/default/locale

RUN mkdir -p /home/user
RUN chmod 777 /home/user

RUN pip3 install pep8

# convoluted setup of rabbitmq + erlang taken from https://www.rabbitmq.com/install-debian.html#apt-quick-start-packagecloud
## Team RabbitMQ's main signing key
RUN curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
## Launchpad PPA that provides modern Erlang releases
RUN curl -1sLf "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf77f1eda57ebb1cc" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg > /dev/null
## PackageCloud RabbitMQ repository
RUN curl -1sLf "https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/io.packagecloud.rabbitmq.gpg > /dev/null
## Add apt repositories maintained by Team RabbitMQ
RUN echo "\
## Provides modern Erlang/OTP releases \
## \
## "bionic" as distribution name should work for any reasonably recent Ubuntu or Debian release. \
## See the release to distribution mapping table in RabbitMQ doc guides to learn more. \
	deb [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu bionic main \
	deb-src [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu bionic main \
## Provides RabbitMQ \
## \
## "bionic" as distribution name should work for any reasonably recent Ubuntu or Debian release. \
## See the release to distribution mapping table in RabbitMQ doc guides to learn more. \
	deb [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ bionic main \
	deb-src [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ bionic main" \
	| sudo tee /etc/apt/sources.list.d/rabbitmq.list
## Update package indices
RUN sudo apt-get update -y
## Install Erlang packages
RUN sudo apt-get install -y erlang-base \
				erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
				erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
				erlang-runtime-tools erlang-snmp erlang-ssl \
				erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl
# hackery to disable autostart at installation https://askubuntu.com/questions/74061/install-packages-without-starting-background-processes-and-services
RUN mkdir /tmp/fake && ln -s /bin/true/ /tmp/fake/initctl && \
				ln -s /bin/true /tmp/fake/invoke-rc.d && \
				ln -s /bin/true /tmp/fake/restart && \
				ln -s /bin/true /tmp/fake/start && \
				ln -s /bin/true /tmp/fake/stop && \
				ln -s /bin/true /tmp/fake/start-stop-daemon && \
				ln -s /bin/true /tmp/fake/service && \
				ln -s /bin/true /tmp/fake/deb-systemd-helper
RUN sudo PATH=/tmp/fake:$PATH apt-get install -y rabbitmq-server

EXPOSE 8080
EXPOSE 8081
EXPOSE 8082
EXPOSE 8083
EXPOSE 8084
EXPOSE 8085
EXPOSE 8086
EXPOSE 8087
EXPOSE 8088
EXPOSE 8089
EXPOSE 8090
EXPOSE 8091
EXPOSE 8093
EXPOSE 8094
EXPOSE 8095

ENV PATH /usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/postgresql/13/bin:${PATH}
