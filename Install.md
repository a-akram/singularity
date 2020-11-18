## Installing Singularity on Ubuntu 18.04

- Read User Guide
- Read Admin Guide

### Step 1: Install Dependencies

```bash
sudo apt-get update && sudo apt-get install -y \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    wget \
    pkg-config \
    git \
    cryptsetup
```

### Step 2: Install go-language

```bash
export VERSION=1.13 OS=linux ARCH=amd64 && \                        # Replace the values as needed
  wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \    # Downloads the required Go package
  sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \     # Extracts the archive
  rm go$VERSION.$OS-$ARCH.tar.gz                                    # Deletes the ``tar`` file
```

Rememeber to Set the environment variable `PATH` to point to `Go`:

```bash
echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc && \        # Export PATH to .bashrc
  source ~/.bashrc                                                  # Source .bashrc
```


### Step 3: Compile/Build Singularity from Source Code

Download Singularity from a release, e.g. `VERSION=3.6.4`

```bash
# Download
export VERSION=3.6.4 && \                                           # adjust this as necessary
    wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
    tar -xzf singularity-${VERSION}.tar.gz && \                     # Extract the tarball
    cd singularity                                                  # cd to the singularity directory
```

Compile the Singularity source code. Dependencies will be automatically downloaded. You can build Singularity using the following commands:

```bash
# Compile/Build Singularity from Source Code.
./mconfig && \
    make -C builddir && \
    sudo make -C builddir install
```

As singularity doesn't provide uninstall script, it is better to provide installation directory where it is easy to remove the singularity or to upgrage it.
Let's breakdown above commands in step by step manner to be more understandable.

```bash
# Compile/Build Singularity from Source Code.
./mconfig --prefix=/usr/local                           # Maybe it's the default already. But let's be sure.
cd builddir
make
sudo make install
```

In case of installation in `/usr/local`, we need to remove files one by one. But what if we install it into a specific directory then its easier to either remove or install a new version while keeping the old one as well.

```bash
# Compile/Build Singularity from Source Code.
./mconfig --prefix=/opt/singularity                     # OR
./mconfig --prefix=/usr/local/singularity               # I prefer this location.      
cd builddir
make
sudo make install
```

Rememeber to Set the environment variable `PATH` to point to `Singularity`:

```bash
echo 'export PATH=/usr/local/singularity/bin:$PATH' >> ~/.bashrc && \
  source ~/.bashrc
```

Now, it is easy to remove an old version (just `sudo rm -rf /usr/local/singularity` or `sudo rm -rf /opt/singularity`). 

## Installation (OLD)

## Step 1: run the script below to remove your existing Singularity:

```bash
#!/bin/bash
#
# A cleanup script to remove Singularity

sudo rm -rf /usr/local/libexec/singularity
sudo rm -rf /usr/local/etc/singularity
sudo rm -rf /usr/local/include/singularity
sudo rm -rf /usr/local/lib/singularity
sudo rm -rf /usr/local/var/lib/singularity/
sudo rm /usr/local/bin/singularity
sudo rm /usr/local/bin/run-singularity
sudo rm /usr/local/etc/bash_completion.d/singularity
sudo rm /usr/local/man/man1/singularity.1
```

## Step 2: run the following script to install Singularity 2.5.1:

```bash
#!/bin/bash
#
# A build script for Singularity (http://singularity.lbl.gov/)

declare -r SINGULARITY_VERSION='3.6.4'
declare -r SINGULARITY_PREFIX='/usr/local'
declare -r SINGULARITY_CONFIG_DIR='/etc'

sudo apt update
sudo apt install python dh-autoreconf build-essential debootstrap

export VERSION=3.6.4         # adjust this as necessary
wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz
tar -xzf singularity-${VERSION}.tar.gz
cd singularity

# Not recommended
# ./mconfig && make -C builddir && sudo make -C builddir install  

# Use this prefix
./mconfig --prefix=/usr/local && \
make -C builddir && \
sudo make -C builddir install  
```

The singularity installed with following prefix couln't build container???

```bash
# Installing other than /usr/local prefix didn't worked. CHECK ???
./mconfig --prefix=/usr/local/singularity && \
make -C builddir && \
sudo make -C builddir install  
```

