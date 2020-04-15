# TODO: move this to ledger-app-particl
FROM buildpack-deps:bullseye

### Install cross compilation tools ###
RUN apt-get update
RUN apt-get -y install gcc-multilib g++-multilib python3-pip
RUN pip3 install Pillow

### Install BOLOS & SDKs ####
RUN mkdir bolos
WORKDIR /bolos

# Install compilers
RUN wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2
RUN wget http://releases.llvm.org/7.0.0/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz
RUN tar xfj gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2
RUN tar xfv clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz
RUN mv clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04 clang-arm-fropi
RUN chmod 757 -R clang-arm-fropi/
RUN chmod +x clang-arm-fropi/bin/clang

# Install the BOLOS SDKs
#RUN git clone https://github.com/LedgerHQ/nanos-secure-sdk.git
RUN git clone https://github.com/kewde/nanos-secure-sdk.git
RUN git clone https://github.com/LedgerHQ/blue-secure-sdk.git

WORKDIR /


### Setup environment variables ###
ENV BOLOS_ENV /bolos
ENV BOLOS_SDK /bolos/nanos-secure-sdk
ENV COIN particl_testnet

### Build the ledger firmware on ledger ###
CMD cd /ledger-app-particl && \ 
    make clean && \
    make

