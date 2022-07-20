FROM debian:bullseye-slim

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
