## Horovod in Conda
---

Follow the guides 

- https://horovod.readthedocs.io/en/stable/conda.html
- https://towardsdatascience.com/building-a-conda-environment-for-horovod-773bd036bf64

## (1) - Creating Environment
---

- **name:** exatrkx

Create environemnt from scratch either using _`conda`_ or _`anaconda-navigator`_.

```bash
# create environment
conda create --name exatrkx
conda activate exatrkx
conda install python=3.8

# composite command is
conda create --name exatrkx python=3.8
```	
OR, we can `clone` the `base` environment which have many packages installed already.

```bash
# clone the 'base' environment
conda create --name exatrkx --clone base -y
conda activate exatrkx
pip install --upgrade pip
```

## (2) - Install CUDA + NVCC, CuDNN, NCCL, CUPTI, etc
---

- NCCL and CuDNN are available on Anaconda
- Horovod Needs [NVCC](https://docs.nvidia.com/cuda/archive/10.1/cuda-compiler-driver-nvcc/index.html)

There are two ways to get NVCC along with CUDATOOLKIT.

### (+) Method # 1

- Install [CUDA 10.1](https://developer.nvidia.com/cuda-10.1-download-archive-update2) on Linux (Ubuntu) which has NVCC installed. More precisely it `10.1.243`, 2nd update.
- Install [nvcc_linux-64](https://anaconda.org/conda-forge/nvcc_linux-64) meta-package from conda-forge repository which will configure conda environment to use CUDA+NVCC from Linux OS.
- Install [CuDNN](), [NCCL]() using conda install.

```bash
$ conda install nvcc_linux-64=10.1          # NVCC : conda search nvcc_linux-64
$ conda install cudnn=7.6.5=cuda10.1_0      # CuDNN: conda search cudnn
$ conda install nccl=2.8.3                  # NCCL : conda search nccl
$ conda install cupti=10.1                  # CUPTI: conda search cupti
```


### (+) Method # 2

- Install [CUDATOOLKIT-DEV]() package from conda-forge it includes NVCC as well
- Install [CuDNN](), [NCCL]() using conda install.

```bash
$ conda install cudatoolkit-dev==10.1.243   # CUDA : conda search cudatoolkit-dev 
$ conda install cudnn=7.6.5=cuda10.1_0      # CuDNN: conda search cudnn
$ conda install nccl=2.8.3                  # NCCL : conda search nccl
$ conda install cupti=10.1                  # CUPTI: conda search cupti
```

## (3) - Install cmake, mpi4py, cxx-compiler, etc
---

```bash
$ conda install cmake=3.16                  # cmake : conda search cmake
$ conda install mpi4py=3.0                  # mpi4py: conda search mpi4py
$ conda install cxx-compiler=1.1            # cxx-compiler: conda search cxx-compiler
$ conda install bokeh=1.4                   # bokeh: conda search bokeh
```

## (4) - Install Deep Learning Frameworks
---

### _(4.1) - Install TensorFlow GPU from PyPi using Pip_

```bash
# TensorFlow
pip install tensorflow-gpu==2.3.0
```

### _(4.2) - Install PyTorch GPU from PyPi using Pip_

```bash
# PyTorch
pip install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html
```

### _(4.3) - Install PyTorch Lighting, Faiss-gpu, Graph_Nets from PyPi using Pip_

```bash
# PyTorch Lighting, Faiss-gpu, Graph Nets, etc
pip install pytorch-lightning==1.0.2 faiss-gpu graph_nets==1.1
```

### _(4.4) - Install Torch PyTorch Geometric from PyPi using Pip_

```bash
#!/bin/bash
CUDA=cu101
TORCH=1.6.0

pip install torch-scatter -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-sparse -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-cluster -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-spline-conv -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-geometric
```

## (5) - Install Additional Packages from Anaconda/PyPi
---

```bash
# essential packages (conda)
conda install scikit-learn scipy numpy pandas matplotlib seaborn jupyterlab notebook jupyter-tensorboard tqdm pyyaml ipywidgets

# OR, essential packages (pip)
pip install scikit-learn scipy numpy pandas matplotlib seaborn jupyterlab notebook jupyter-tensorboard tqdm pyyaml ipywidgets
```

## (6) - Installing TrackML from VCS (Git)
---

```bash
# Inside Conda environment: $HOME/anaconda/envs/heptrkx/lib/python3.8/site-packages
pip install git+https://github.com/LAL/trackml-library.git

# Outside Conda environment: $HOME/.local/lib/python3.8/site-packages
pip install --user git+https://github.com/LAL/trackml-library.git                   
```

### (+) Alternative Methods to Install from VCS
There are other ways to instsall packages from VCS (Git, Gitlab, etc), see details in `workspace/linux/pip.md` or gist named `pip-install.md` on GitHub. 

```bash
# Installing from Tarball/Zip
pip install https://github.com/LAL/trackml-library/tarball/main   

# Following PEP440 Refs.                             
pip install trackml@https://github.com/LAL/trackml-library/tarball/master#egg=trackml-3    
pip install "trackml@ https://github.com/LAL/trackml-library/tarball/master#egg=trackml-3"
pip install trackml@git+https://github.com/LAL/trackml-library.git@master
```

## (7) - Install Horovod
---

- Set _**ENV**_ variables for HOROVOD
- Important are MPI/GLOO, NCCL, DL Framework, etc

To install Horovod with specific settings set environment variables for Horovod, absence usually mean building with support of all possible options.

```bash
# HOROVOD
export ENV_PREFIX=$CONDA_PREFIX           # Get name of currently activated env
export HOROVOD_CUDA_HOME=$CUDA_HOME       # CUDA installation e.g. /usr/local/cuda
export HOROVOD_NCCL_HOME=$CONDA_PREFIX    # NCCL installation e.g. ~/anaconda/envs/horovod 

export HOROVOD_CPU_OPERATIONS=MPI         # MPI/GLOO/CCL for CPU tensor allreduce, allgather, and broadcast.
export HOROVOD_GPU_OPERATIONS=NCCL        # NCCL/MPI for GPU tensor allreduce, allgather, and broadcast

# Default: both will be enabled
export HOROVOD_WITH_MPI=1                 # MPI enabled. To use MPI instead of horovodrun MPI wrapper
export HOROVOD_WITHOUT_GLOO=1             # Gloo disabled. To use Gloo instead of horovodrun MPI wrapper

export HOROVOD_WITH_PYTORCH=1             # Force installation with PyTorch, use *_WITHOUT_*=1 if not needed.
export HOROVOD_WITH_TENSORFLOW=1          # Force installation with TensorFlow, use *_WITHOUT_*=1 if not needed.
```

```bash
pip install horovod==0.20                 # OR, how to give [tensorflow,pytorch] ???
pip install horovod[tensorflow,pytorch]   # how to give version ???
```

### (+) - Check Build

After successfully installing Horovod, run:

```bash
$ horovodrun --check-build
Horovod v0.20.0:

Available Frameworks:
    [X] TensorFlow
    [ ] PyTorch
    [ ] MXNet

Available Controllers:
    [X] MPI
    [X] Gloo

Available Tensor Operations:
    [X] NCCL
    [ ] DDL
    [ ] CCL
    [X] MPI
    [X] Gloo
```

Every feature that was successfully enabled will be marked with an ‘X’. If you intended to install Horovod with a feature that is not listed as enabled, you can reinstall Horovod, setting the appropriate environment variables to diagnose failures:


## Summary (Exa.TrkX)
___

- **NOTE:** [According to Official Guide](https://horovod.readthedocs.io/en/latest/conda.html)
- **NOTE:** specific versions of packages are important to successfully build HOROVOD
- **NOTE:** copy and paste commands successively.
- **NOTE:** Summary section might be more updated in relavant files _e.g._ `exatrkx.md, tfh.md` etc.

### (+) - Creating Conda Environment
---

```bash
# create environment
# conda create --name exatrkx --clone base -y      # OR
conda create --name exatrkx python=3.8
conda activate exatrkx
```

### (+) - NVCC: Install cudatoolkit-dev when cudatoolkit isn't installed w/ APT.
---

```bash
# conda install <package>
conda install cudatoolkit-dev==10.1.243 cudnn=7.6 nccl=2.5 cupti=10.1 cmake=3.16 mpi4py=3.0 cxx-compiler=1.0 bokeh=1.4 nodejs=13
```

### (+) - NVCC: Install nvcc_linux-64 package when cudatoolkit is installed w/ APT.
---

```bash
# Conda Packages of NVCC, CuDNN, NCCL, etc. (cudatoolkit installed w/ apt.)
$ conda install nvcc_linux-64=10.1 cudnn=7.6 nccl=2.5 cupti=10.1 cmake=3.16 mpi4py=3.0 cxx-compiler=1.0 bokeh=1.4 nodejs=13
```
### (+) - Additional Conda Packages
---

```bash
# Conda Packages of SciPy, NumPy, Pandas, etc
pip install scikit-learn scipy numpy pandas matplotlib seaborn jupyterlab notebook jupyter-tensorboard tqdm pyyaml ipywidgets
```

### (+) - Install Deep Learning Frameworks
---

```bash
# Pip Packages of Frameworks + Additional 
pip install tensorflow-gpu==2.3.0
pip install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html
pip install pytorch-lightning==1.0.2 faiss-gpu graph_nets==1.1
```

### (+) - Install PyTorch Geometric
---

```bash
#!/bin/bash
CUDA=cu101
TORCH=1.6.0

pip install torch-scatter -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-sparse -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-cluster -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-spline-conv -f https://pytorch-geometric.com/whl/torch-${TORCH}+${CUDA}.html
pip install torch-geometric
```

### (+) - Install Horovod
---


```bash
# CUDA on Linux (.bashrc or .bash_profile)
# export CUDA_HOME=/usr/local/cuda
# export PATH=$CUDA_HOME/bin:$PATH
# export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# Important HOROVOD Variables
# export ENV_PREFIX=$CONDA_PREFIX
# export HOROVOD_CUDA_HOME=$CUDA_HOME
# export HOROVOD_NCCL_HOME=$ENV_PREFIX
# export HOROVOD_GPU_OPERATIONS=NCCL
```
**OR**

```bash
#!/bin/bash
HOROVOD_CUDA_HOME=$CUDA_HOME && \
HOROVOD_NCCL_HOME=$CONDA_PREFIX  && \
HOROVOD_CPU_OPERATIONS=MPI  && \
HOROVOD_GPU_OPERATIONS=NCCL  && \
HOROVOD_WITH_MPI=1  && \
HOROVOD_WITHOUT_GLOO=1  && \
HOROVOD_WITHOUT_PYTORCH=1  && \
HOROVOD_WITH_TENSORFLOW=1  && \
pip install horovod==0.19.* jupyterlab-nvdashboard==0.2.* jupyter-tensorboard==0.2.* --no-binary=horovod

[Worked]
```
**OR**

```bash
#!/bin/bash
HOROVOD_CUDA_HOME=$CUDA_HOME && \
HOROVOD_NCCL_HOME=$CONDA_PREFIX  && \
HOROVOD_GPU_OPERATIONS=NCCL  && \
HOROVOD_WITH_MPI=1  && \
pip install horovod==0.19.* jupyterlab-nvdashboard==0.2.* jupyter-tensorboard==0.2.* --no-binary=horovod

[SAME,Worked]
```


**OR**

```bash
# Example
pip uninstall horovod
HOROVOD_CUDA_HOME=$CUDA_HOME && \
HOROVOD_NCCL_HOME=$CONDA_PREFIX  && \
HOROVOD_CPU_OPERATIONS=MPI  && \
HOROVOD_GPU_OPERATIONS=NCCL  && \
HOROVOD_WITH_MPI=1  && \
HOROVOD_WITHOUT_GLOO=1  && \
HOROVOD_WITHOUT_PYTORCH=1  && \
HOROVOD_WITH_TENSORFLOW=1  && \
pip install --no-cache-dir horovod
```

### (+) - Post Build
---

```bash
# post build
jupyter labextension install --no-build jupyterlab-nvdashboard
jupyter labextension install --no-build jupyterlab_tensorboard
jupyter lab build
```

### (+) - Check Build
---

```bash
# check build
horovodrun --check-build

Horovod v0.19.5
Available Frameworks:
    [X] TensorFlow
    [X] PyTorch
    [ ] MXNet
Available Controllers:
    [X] MPI
    [X] Gloo
Available Tensor Operations:
    [X] NCCL
    [ ] DDL
    [ ] CCL
    [X] MPI
    [X] Gloo
```
---