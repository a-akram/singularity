
## Install CUDA 10.1 on Ubuntu 18.04

- Ubuntu 18.04
- Cuda 10.1 Update 2
- CuDNN 7.6.5

## Tutorials

- [CUDA 10.1 Installation on Ubuntu 18.04](https://gist.github.com/Mahedi-61/2a2f1579d4271717d421065168ce6a73)
- [CUDA 10.1 Installation on Ubuntu 18.04](https://medium.com/@exesse/cuda-10-1-installation-on-ubuntu-18-04-lts-d04f89287130)
- [CUDA 10.2 + CUDNN v7.6.5 on Ubuntu 18.04](https://sh-tsang.medium.com/tutorial-cuda-v10-2-cudnn-v7-6-5-installation-ubuntu-18-04-3d24c157473f)



## Meet the Pre-requisites

- See official documentation etc


## 1. _Remove any NVIDIA traces you may have on your machine_

```bash
# caution with these steps
sudo rm /etc/apt/sources.list.d/cuda*
sudo apt remove --autoremove nvidia-cuda-toolkit
sudo apt remove --autoremove nvidia-*

# OR these ones???
sudo apt-get purge nvidia*
sudo apt remove nvidia-*
sudo rm /etc/apt/sources.list.d/cuda*
sudo apt-get autoremove && sudo apt-get autoclean
sudo rm -rf /usr/local/cuda*
```

### (+) Do NOT Install Nvidia driver

- During CUDA 10 installation, the driver will be installed. So just go ahead and install CUDA!!!

## 2. _Setup the Correct CUDA PPA on Ubuntun_

```bash
# adding repos
sudo apt update
sudo add-apt-repository ppa:graphics-drivers
sudo apt-key adv --fetch-keys  http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list'
```


```bash
# OR try these ones for adding repos
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda-ml.list
```

## 3._ Install CUDA 10.1 Packages_
---

```bash
sudo apt update
sudo apt install cuda-10-1
sudo apt install libcudnn7
```

## 4. _Set PATH Variable_
---

Reboot the system to load the NVIDIA drivers. Set up the development environment by modifying the PATH and LD_LIBRARY_PATH variables:


### (+) - _Specify `PATH` to CUDA in `~/.bashrc` file._


```bash
# setup your paths
echo 'export PATH=/usr/local/cuda-10.1/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
```

### (+) - _Alternatively, specify `PATH` to CUDA in `~/.profile` file._

```bash
# open .profile
sudo vi ~/.profile

# set PATH for cuda 10.1 installation
if [ -d "/usr/local/cuda-10.1/bin/" ]; then
    export PATH=/usr/local/cuda-10.1/bin${PATH:+:${PATH}}
    export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
fi
```

## 5. _Restart and check the versions for the installation_

```bash
# check CUDA
$ nvcc  --version

nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2019 NVIDIA Corporation
Built on Wed_Apr_24_19:10:27_PDT_2019
Cuda compilation tools, release 10.1, V10.1.168
```

```bash
# check nvidia drivers
nvidia-smi
```

```bash
# check libcudnn (didn't worked.)
/sbin/ldconfig -N -v $(sed ‘s/:/ /’ <<< $LD_LIBRARY_PATH) 2>/dev/null | grep libcudnn
```