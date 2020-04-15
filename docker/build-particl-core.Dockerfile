FROM buildpack-deps:bullseye

### Update && install dependency  ###
RUN apt-get update
RUN apt-get install libudev-dev

### Build particl-core (daemon & QT)  ###
CMD cd /particl-core/depends/ && \
    make -j2 && \
    cd /particl-core && \
    ./autogen.sh && \
    ./configure --with-incompatible-bdb --disable-tests --disable-bench --enable-debug --enable-usbdevice --disable-dependency-tracking --prefix=$(pwd)/depends/x86_64-pc-linux-gnu && \
    make -j 2