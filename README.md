## **Singularity Container**

## (+) Fetching Base Images from DockerHub

The important thing to note is the fetching the base image for the container _e.g._ `From: debian:buster` or `From: ubuntu:bionic` will fetch Debian 10.10 and Ubuntu 18.04 LTS. Important headers are the following:

```bash
# Fetch Ubuntu 18.04 LTS
Bootstrap: docker
From: ubuntu:bionic              # Either, use name of OSDistro

Bootstrap: docker
From: ubuntu:18.04               # Or, use numeral of OSDistro
```

```bash
# Fetch Debian 10
Bootstrap: docker
From: debian:buster              # Either, use name of OSDistro

Bootstrap: docker
From: ubuntu:10.10               # Or, use numeral of OSDistro
```

## (+) Fetching Base Images from Singularity


```bash
# Fetch Ubuntu 18.04 LTS
Bootstrap: library
From: ubuntu:bionic              # Either, use name of OSDistro

Bootstrap: library
From: ubuntu:18.04               # Or, use numeral of OSDistro
```

```bash
# Fetch Debian 10
Bootstrap: library
From: debian:buster              # Either, use name of OSDistro

Bootstrap: library
From: ubuntu:10.10               # Or, use numeral of OSDistro
```



## (+) Example Definition

```bash
# HEADER
Bootstrap: docker
From: debian:buster

# SECTIONS
%post

    # *** OS Upgrade & Install
    apt update && apt upgrade -y
    apt install -y \
        build-essential \
        git \
        curl \
        vim \
        wget \
        cmake \
        ca-certificates

    # *** Setting Up FairSoft
    mkdir -p /fairsoft/src /fairsoft/build /fairsoft/install
    cd /fairsoft
    git clone -b apr21p1 https://github.com/FairRootGroup/FairSoft src
    
    src/legacy/setup-ubuntu.sh
    src/bootstrap-cmake.sh /usr/local

    cmake -S ./src -B ./build -C ./src/FairSoftConfig.cmake -DCMAKE_INSTALL_PREFIX=./install
    cmake --build ./build -j8

    # *** Test Installation
    du -hs /fairsoft/install

    # *** Cleanup
    rm -rf /fairsoft/src
    rm -rf /fairsoft/build

%environment

    # Export FairSoft
    # export SIMPATH=/fairsoft/install
```