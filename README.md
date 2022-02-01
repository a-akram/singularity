## **Singularity**
[Singularity](https://sylabs.io/singularity/) is a container platform. It allows you to create and run containers that package up pieces of software in a way that is portable and reproducible. You can build a container using Singularity on your laptop, and then run it on many of the largest HPC clusters in the world, local university or company clusters, a single server, in the cloud, or on a workstation down the hall. Your container is a single file, and you don’t have to worry about how to install all the software you need on each different operating system.

- Free, cross-platform and open-source platform for OS-level virtualization (_a.k.a_ **containerization**)
- Provides software __portability__ and __reproducibility__
- Main use is in an **HPC** environment but a local use works just fine
- Two versions exists: Pro Edition, and Community Edition (CE)

## Singularity Definition Files

```bash
# HEADER
Bootstrap: docker
From: ubuntu:18.04

# SECTIONS
%setup, %files, %environment, %post, %runscript, %startscript, %help, ...

```


### (+) Fetching Base Images from DockerHub

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

### (+) Fetching Base Images from Container Library


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
    rm -rf /fairsoft/src /fairsoft/build
```

## Building Containers

```bash
# Clone the Repository
$ git clone git@gitlab.com:uuanalysis/singularity.git
$ cd singulairty

# Now build containers one by one
$ sudo singularity build fairsoft.sif fairsoft.def
$ sudo singularity build fairroot.sif fairroot.def
$ sudo singularity build pandaroot.sif pandaroot.def

# Remove fairsoft, fairroot (You can keep it for future)
$ rm fairsoft.sif fairroot.def
```
## Run Containers

```bash
# run PandaRoot
$ ./root.sh macro.c
```