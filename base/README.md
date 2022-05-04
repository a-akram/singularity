## Base Image for Containers

### Fetching Base Images from DockerHub

The important thing to note is the fetching the base image for the container _e.g._ `From: debian:buster` or `From: ubuntu:bionic` will fetch Debian 10.10 or Ubuntu 18.04 LTS from DockerHub, respectively.

```bash
# HEADER
Bootstrap: docker
From: ubuntu:18.04

# SECTIONS
%setup, %files, %environment, %post, %runscript, %startscript, %help, ...

```

### (+) Debian/Ubuntu Base Image from DockerHub

```bash
# Fetch Debian 10.10
Bootstrap: docker
From: debian:buster              # Either, use name of OSDistro

Bootstrap: docker
From: ubuntu:10.10               # Or, use numeral of OSDistro
```

```bash
# Fetch Ubuntu 18.04
Bootstrap: docker
From: ubuntu:bionic              # Either, use name of OSDistro

Bootstrap: docker
From: ubuntu:18.04               # Or, use numeral of OSDistro
```

### (+) Cuda Base Image from DockerHub

The Nividia provides official base images on DockerHub for [CUDA](https://hub.docker.com/r/nvidia/cuda) which are build on top of Ubuntu Linux (LTS) distribution. There are three CUDA flavours available:

- `base`: Includes the CUDA runtime (cudart)
- `runtime`: Builds on the `base` and includes the CUDA math libraries, and NCCL. A runtime image that also includes cuDNN is available.
- `devel`: Builds on the `runtime` and includes headers, development tools for building CUDA images. These images are particularly useful for multi-stage builds.

The latest _CUDA (11.6) + Ubuntu (20.04)_ base image can be feteched in one of above flavours

```bash
# Fetch a Base Flavour
Bootstrap: docker
From: 11.6.0-base-ubuntu20.04
```

```bash
# Fetch a Runtime Flavour
Bootstrap: docker
From: 11.6.0-runtime-ubuntu20.04
```

```bash
# Fetch a Devel Flavour (Mostly required)
Bootstrap: docker
From: 11.6.0-devel-ubuntu20.04
```


### (+) Aanconda Base Image from DockerHub

The Anaconda Inc. provides official base images on DockerHub for both [Anaconda3](https://hub.docker.com/r/continuumio/anaconda3) and [Miniconda3](https://hub.docker.com/r/continuumio/miniconda3) which are built on top of Debian Linux distribution. Both can be feteched from their official channel on [DockerHub](https://hub.docker.com/u/continuumio)

```bash
# Fetch Anaconda (Debian Based)
Bootstrap: docker
From: From: continuumio/anaconda3
```

```bash
# Fetch Miniconda (Debian Based)
Bootstrap: docker
From: From: continuumio/miniconda3
```












### Fetching Base Images from Container Library

Alternatively, one can also fetch a base image from container library hosted by Singularity.

```bash
# Fetch Ubuntu 18.04
Bootstrap: library
From: ubuntu:bionic              # Either, use name of OSDistro

Bootstrap: library
From: ubuntu:18.04               # Or, use numeral of OSDistro
```

```bash
# Fetch Debian 10.10
Bootstrap: library
From: debian:buster              # Either, use name of OSDistro

Bootstrap: library
From: ubuntu:10.10               # Or, use numeral of OSDistro
```

## Example Miniconda Singularity Definition

```bash
# HEADER
Bootstrap: docker
From: continuumio/miniconda3

# SECTIONS
%files
    README.md
    setup.py
    gpu_environment.yml
    
%post
    
    # *** Non-interactive Shell
	export DEBIAN_FRONTEND=noninteractive
    
    # *** Reconfigure Shell (or %post -c /bin/bash)
    dpkg-reconfigure dash
    
    # *** OS Upgrade & Install
    apt update && apt upgrade -y
    apt install -y git wget \
        build-essential \
		ca-certificates \
        libgl1-mesa-glx \
        libegl1-mesa \
		libxrandr2 \
		libxss1 \
		libxcursor1 \
		libxcomposite1 \
		libasound2 \
		libxi6 \
		libxtst6
	
	# Load Anaconda Environment Variables
	. /opt/conda/etc/profile.d/conda.sh
	
	# Update Conda
	conda update conda
	
	# *** Setting Up Envrionmnet
    conda env create -f gpu_environment.yml python=3.8
    conda activate exatrkx-gpu
    pip install -e .
    
    # *** Setup Conda Init ***
	mv ~/.bashrc ~/.bashrcold
	conda init
	cat ~/.bashrc >> /etc/conda.init
	echo conda activate exatrkx-gpu >> /etc/conda.init
	conda clean -afy
	mv ~/.bashrcold ~/.bashrc
	rm *.py *.yml *.md
	
    # *** Cleanup
    apt clean && \
    rm -rf /var/lib/apt/lists/*
    
%environment
	action="${1##*/}"
	if [ "$action" = "shell" ]; then
		if [ "${SINGULARITY_SHELL:-}" = "/bin/bash" ]; then
			set -- --noprofile --init-file /etc/conda.init
		elif test -z "${SINGULARITY_SHELL:-}"; then
			export SINGULARITY_SHELL=/bin/bash
			set -- --noprofile --init-file /etc/conda.init
		fi
	fi	

%runscript
	BASH_ENV=/etc/conda.init exec /bin/bash --noprofile --init-file /etc/conda.init "$@"

%labels
    Author: Adeel Akram <adeel.chep@gmail.com>
    Dated : 01-01-2022
```
